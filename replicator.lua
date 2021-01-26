local debug = require("component").debug
local ttf = require()
local world = debug.getWorld();

ic2repID = "ic2:replicator";
local ie_hf = {"immersiveengineering:metal_decoration0", 5, 2}; 
local te_f = {"thermalexpansion:frame", 0, 0};

patterns = {}

rep_pos = {130, 63, -844}
pstr_pos = {131, 63, -844}
nbt = world.getTileNBT(rep_pos[1],rep_pos[2], rep_pos[3]);

local swap = ie_hf;


function Init()
    if nbt.value.id.value ~= ic2repID then return end


    
end

function ClearPatterns()
    for k in pairs(patterns) do
        patterns[k] = nil
    end
end
 -- pnbt = component.debug.getWorld().getTileNBT(pstr_pos[1],pstr_pos[2], pstr_pos[3])
function GetPatterns()
    ClearPatterns();
    local pnbt = world.getTileNBT(pstr_pos[1],pstr_pos[2], pstr_pos[3]);

    for i = 1,pnbt.value.patterns.value.n do
        val = pnbt.value.patterns.value[i].value
        tab = {val.id.value, val.Damage.value, i-1}
        print(tab[1])
        table.insert(patterns, 1, tab)
    end
end

function SetReplicator(pat)
    nbt.value.pattern.value.id.value = swap[1];
    nbt.value.pattern.value.Damage.value = swap[2];
    nbt.value.index.value = swap[3];
    world.setTileNBT(-105, 91, 64, tNBT);
end




-- nbt = component.debug.getWorld().getTileNBT(130, 63, -844);
-- pnbt = component.debug.getWorld().getTileNBT(131, 63, -844);

-- component.debug.getWorld().setTileNBT(130 63 -844, nbt);