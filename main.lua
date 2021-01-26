local tsave = require("tableToFile");

repBlockNames = {}

function Load()
    repBlockNames = tsave.load("replications.table");
end
function Save()
    tsave.save(repBlockNames, "replications.table");
end

function ChestGetAddBlocks()
-- Load table

-- Get items in the chest
-- Loop over items in chest 
-- Get their data: unlocalised name and metadata (called Damage in replicator)
-- Add them to repBlockNames where localised name is key and data is value

-- Save table
end

function AddBlock(blockName, repData)
    Load();
    repBlockNames[blockName] = repData;
    Save();
end