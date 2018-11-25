require("./data/mods/PoraComp/LUA/monster_attacks")
require("./data/mods/PoraComp/LUA/functions")
require("./data/mods/PoraComp/LUA/iuse_actions")
require("./data/mods/PoraComp/LUA/coroutines")

local MOD = {
  id = "porawep",
  version = "2018-11-25"
}
mods[MOD.id] = MOD
DEBUG = false
para_chatter = 0

MOD.on_turn_passed = function()
	para_chatter = para_chatter + 1
end

MOD.on_day_passed = function()
	zygote_growth()
end