module("program", package.seeall)

tsave = require("tableToFile"); 
component = require("component");
rep_debug = component.debug;
rep_db = component.database;
rep_world = rep_debug.getWorld();

rep_main = require("main")
rep_base = require("replicator")


mainmod.Main();