local tsave = require("tableToFile");
local debug = require("component").debug;
local db = component.database;
local world = debug.getWorld();

RepNames = {}
RepNames.ic2rep = "ic2:replicator";
RepNames.chest = "minecraft:chest";

RepApp = {}

RepApp.isSafe = false;
RepApp.init = false;
RepApp.Conf = {}
RepApp.Conf.SearchInvPos = {}
RepApp.Conf.ReplicatorPos = {}

repBlockNames = {}


function Main()
    io.write("Welcome to the Replicator Interface ;)\n")

    io.write("quick -- setup alt: use the attached database (first 9 slots only) to load positions")
    io.write("setup -- you will need to setup the position of the machines before anything else.\n")
    io.write("exec -- run the main program.\n")
    io.write("show -- prints the configs\n")
    local ui = io.read();

    if ui == "setup" then Setup();
    elseif ui == "quick" then 
        
    end
end

function DBGetSub(name)
    
end

function DBSetup()
    DBLoc = {}
    DBLoc.pat = {}
    DBLoc.scan = {}
    DBLoc.rep = {}
    for i = 1,9,1 do 
        temp = db.get(i)["name"]
        if temp == "minecraft:paper" then
            dbtemp = nil
            local counter = 0
            for i,d in string.gmatch(temp["label"], "%S+") do 
                if dbtemp == nil then
                    if i == "pat" then
                        dbtemp = DBLoc.pat;
                    elseif i == "scan" then
                        dbtemp = DBLoc.scan;
                    elseif i == "rep" then
                        dbtemp = DBLoc.rep;
                    end
                end
                dbtemp["test"] = i;
                counter = counter + 1;
            end
            dbtemp = nil
        end 
    end
    print(DBLoc)
end
    
RepApp.Conf.ReplicatorPos = AskLocation(RepNames.ic2rep)
RepApp.Conf.SearchInvPos = AskLocation(RepNames.chest)
end

function Setup()
    RepApp.Conf.ReplicatorPos = AskLocation(RepNames.ic2rep)
    RepApp.Conf.SearchInvPos = AskLocation(RepNames.chest)
    
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
            print("Block ".. ask .." found at ".. rep_pos[1] .. ",".. rep_pos[1] .. ",".. rep_pos[1])
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