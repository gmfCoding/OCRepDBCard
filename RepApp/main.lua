local tsave = require("tableToFile");
local debug = require("component").debug;
local world = debug.getWorld();

RepApp = {}

RepApp.isSafe = false;
RepApp.init = false;
RepApp.Conf = {}
RepApp.Conf.SearchInvPos = {}
RepApp.Conf.ReplicatorPos = {}

repBlockNames = {}


function Main()
    io.write("Welcome to the Replicator Interface ;)\n")

    io.write("setup -- you will need to setup the position of the machines before anything else.\n")
    io.write("exec -- run the main program.\n")
    io.write("show -- prints the configs\n")
    local ui = io.read();

    if ui == "setup" then Setup();
    elseif ui == "exec" then 
    end
end

function Setup()
    RepApp.Conf.ReplicatorPos = AskLocation("ic2:replicator")
    RepApp.Conf.SearchInvPos = AskLocation("minecraft:chest")
    
    if RepApp.Conf.ReplicatorPos == nil or RepApp.Conf.SearchInvPos == nil then
        io.write("Couldn't find Replicator or Search Chest. \n");
        return
    end

    tsave.save(RepApp.Conf, "config.table");
end

function AskLocation(ask)
    print(ask.." location couldn't be verified. \nINPUT: X Y Z\n");
    local rd = io.read();
    local rep_pos = {}

    for i,d in string.gmatch(rd, "%S+") do
        table.insert(rep_pos, tonumber(i));
    end

    if tablelength(rep_pos) >= 3 then
        local verified = VerifyTEPos(ask, rep_pos[1], rep_pos[2], rep_pos[3])
        if verified then
            print("Block "..ask.." found at ".. rep_pos)
            return rep_pos
        end
    end
    print("Block "..ask.." not found at ".. rep_pos)
    return nil
end

function VerifyTEPos(ask, x, y, z)
    if world.hasTileEntity(x, y, z) == false then
        return false
    end

    local bName = world.getTileNBT(x, y, z).value.id.value;
    
    if bName == ask then
        return true;
    end
    return false;
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
    -- asd
end
-- Load table

-- Get items in the chest
-- Loop over items in chest 
-- Get their data: unlocalised name and metadata (called Damage in replicator)
-- Add them to repBlockNames where localised name is key and data is value

-- Save table


function RepApp.AddBlock(blockName, repData)
    Load();
    repBlockNames[blockName] = repData;
    Save();
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do 
        count = count + 1 
    end
    return count
end

Main();