program = {}

program.tsave = require("tableToFile"); 
program.component = require("component");

program.rep_db = component.database;
program.rep_debug = component.debug;
program.rep_world = component.debug.getWorld();

program.rep_main = require("main")
program.rep_base = require("replicator")

program.rep_main.Main();

return program;