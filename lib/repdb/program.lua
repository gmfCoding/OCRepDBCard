program = {}

local tsave = require("tableToFile"); 
local component = require("component");

local rep_db = component.database;
local rep_debug = component.debug;
local rep_world = component.debug.getWorld();

program.tsave = tsave;
program.component = component;
program.rep_db = rep_db;
program.rep_debug = rep_debug;
program.rep_world = rep_world;


local rep_main = require("main")
program.rep_main = rep_main;

local rep_base = require("replicator")
program.rep_base = rep_base;

rep_main.Main();

return program;