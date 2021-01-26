local tsave = require("tableToFile");
local debug = require("debug");
local world = debug.getWorld();


RepApp = {}

RepApp.isSafe = false;
RepApp.init = false;
RepApp.Conf = {}
RepApp.Conf.SearchInvPos = {}
RepApp.Conf.ReplicatorPos = {}

repBlockNames = {}


function Main()
    io.write("Welcome to the Replicator Interface ;)")

    io.write("setup -- you will need to setup the position of the machines before anything else.")
    io.write("exec -- run the main program.")
    io.write("show -- prints the configs")
    local ui = io.read();

    if ui == "setup" then Setup();
    elseif ui == "exec" then 
    end
end

function Setup()
    RepApp.Conf.ReplicatorPos = AskLocation("ic2:replicator")
    RepApp.Conf.SearchInvPos = AskLocation("minecraft:chest")
    
    if RepApp.Conf.ReplicatorPos == nil or RepApp.Conf.SearchInvPos == nil then
        io.write("Couldn't find Replicator or Search Chest");
        return
    end

    tsave.save(RepApp.Conf, "config.table");
end

function AskLocation(ask)
    io.write(ask.." location couldn't be verified, TRY:"..tryCount.."/4 Please input X Y Z");
    local rd = io.read();
    local rep_pos = string.gmatch(rd,"%S+");
    if tablelength(rep_pos) >= 3 then
        local verified = VerifyRepPos(ask, rep_pos[1], rep_pos[2], rep_pos[3])
        if verified then
            return rep_pos
        end
    end
    return nil
end

function VerifyRepPos(ask, x, y, z)
    local bName = world.getBlockId(x,y,z);
    if bName ~= ask then
        return false;
    end
    return true;
end

function RepApp.LoadLocations()
    tsave.load(RepApp.Conf, "config.table")
end

function RepApp.LoadPatterns()
    repBlockNames = tsave.load("replications.table");
    return repBlockNames;
end

function RepApp.SaveLoadPatterns()
    tsave.save(repBlockNames, "replications.table");
end

function RepApp.ChestGetAddBlocks()
-- Load table

-- Get items in the chest
-- Loop over items in chest 
-- Get their data: unlocalised name and metadata (called Damage in replicator)
-- Add them to repBlockNames where localised name is key and data is value

-- Save table
end

function RepApp.AddBlock(blockName, repData)
    Load();
    repBlockNames[blockName] = repData;
    Save();
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end


Main();
end