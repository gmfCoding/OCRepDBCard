local tsave = require("tableToFile");
local debug = require("component").debug;
local REP = require("replicator")
local db = component.database;
local world = debug.getWorld();

RepNames = {}
RepNames.ic2rep = "ic2:replicator";
RepNames.ic2pat = "ic2:pattern_storage";

RepApp = {}

RepApp.isSafe = false;
RepApp.init = false;
RepApp.alive = true;
RepApp.Conf = {}
RepApp.Conf.ReplicatorPos = nil
RepApp.Conf.ScannerPos = nil
RepApp.Conf.PatternPos = nil

repBlockNames = {}


function Main()
    print("Welcome to the Replicator Interface ;)\n")

    print("quick -- setup alt: use the attached database (first 9 slots only) to load positions")
    print("setup -- you will need to setup the position of the machines before anything else.\n")
    print("exec -- run the main program.\n")
    print("show -- prints the configs\n")
    while RepApp.alive == true do
        local ui = io.read();
        if ui == "setup" then Setup();
        elseif ui == "quick" then DBSetup()
        elseif ui == "exec" then REP.Init()
        end
    end
end

function DBSetup()
    DBLoc = {}
    DBLoc.pat = {}
    DBLoc.scan = {}
    DBLoc.rep = {}
    for i = 1,9,1 do 
        temp = db.get(i);
        if temp ~= nil and temp["name"] == "minecraft:paper" then
            dbtemp = nil
            local counter = 1
            for i,d in string.gmatch(temp["label"], "%S+") do 
                if dbtemp == nil then
                    if i == "pat" then
                        dbtemp = DBLoc.pat;
                    elseif i == "scan" then
                        dbtemp = DBLoc.scan;
                    elseif i == "rep" then
                        dbtemp = DBLoc.rep;
                    end
                else
                    dbtemp[counter] = i;
                    counter = counter + 1;
                end
            end
            dbtemp = nil
        end 
    end
    print(DBLoc)
    RepApp.Conf.ReplicatorPos = DBLoc.rep
    RepApp.Conf.ScannerPos = DBLoc.scan
    RepApp.Conf.PatternPos = DBLoc.pat
end

function Setup()
    RepApp.Conf.ReplicatorPos = AskLocation(RepNames.ic2rep)
    RepApp.Conf.PatternPos = AskLocation(RepNames.ic2pat)
    
    if RepApp.Conf.ReplicatorPos == nil or RepApp.Conf.PatternPos == nil then
        print("Couldn't find Replicator or Pattern Storage. \n");
        return
    end
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

-- Block Location Serialisation
function RepApp.LoadLocations()
    tsave.load(RepApp.Conf, "config.table")
end

function RepApp.SaveLocations()
    tsave.save(RepApp.Conf, "config.table");
end

-- Pattern Serialisation
function RepApp.LoadPatterns()
    repBlockNames = tsave.load("replications.table");
    return repBlockNames;
end

function RepApp.SaveLoadPatterns()
    tsave.save(repBlockNames, "replications.table");
end

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