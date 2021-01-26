local debug = program.rep_debug;
local world = program.rep_world;

local this = {}

local replication = {}
replication.patterns = {}
replication.repPos = {}
replication.patPos = {}

--local ie_hf = {"immersiveengineering:metal_decoration0", 5, 2}; 
--local te_f = {"thermalexpansion:frame", 0, 0};

local patterns = {}

function this.Init()
    replication.patPos = mainmod.RepApp.Conf.PatternPos
    FindPatterns()

    for i, d in pairs(patterns) do
        print(i);
    end
end

function this.ClearPatterns()
    for k in pairs(patterns) do
        patterns[k] = nil
    end
end

function this.FindPatterns()
    ClearPatterns();
    local pnbt = world.getTileNBT(replication.patPos[1], replication.patPos[2], replication.patPos[3]);

    for i = 1,pnbt.value.patterns.value.n do
        val = pnbt.value.patterns.value[i].value
        tab = {val.id.value, val.Damage.value, i-1}
        print(tab[1])
        table.insert(patterns, 1, tab)
    end
end

function this.SetReplicator(pat)
    nbt.value.pattern.value.id.value = swap[1];
    nbt.value.pattern.value.Damage.value = swap[2];
    nbt.value.index.value = swap[3];
    world.setTileNBT(-105, 91, 64, tNBT);
end


this.replication = replication;
this.patterns = patterns;
return this;