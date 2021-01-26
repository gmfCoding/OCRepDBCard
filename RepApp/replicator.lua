local debug = require("component").debug
local world = debug.getWorld();

Replication = {}
Replication.patterns = {}
Replication.repPos = {}
Replication.patPos = {}

--local ie_hf = {"immersiveengineering:metal_decoration0", 5, 2}; 
--local te_f = {"thermalexpansion:frame", 0, 0};

patterns = {}

function Init()
    Replication.patPos = mainmod.RepApp.Conf.PatternPos
    FindPatterns()

    for i, d in pairs(patterns) do
        print(i);
    end
end

function ClearPatterns()
    for k in pairs(patterns) do
        patterns[k] = nil
    end
end

function FindPatterns()
    ClearPatterns();
    local pnbt = world.getTileNBT(Replication.patPos[1], Replication.patPos[2], Replication.patPos[3]);

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