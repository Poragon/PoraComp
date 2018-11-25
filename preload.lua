require("./data/mods/PoraComp/LUA/monster_attacks")
require("./data/mods/PoraComp/LUA/functions")

local MOD = {
  id = "porawep",
  version = "2018-11-25"
}
mods[MOD.id] = MOD
DEBUG = false

MOD.on_turn_passed = function()
	monster_update_tick(monsters_around())
end
