require("data/mods/PoraComp/LUA/monster_attacks")
require("data/mods/PoraComp/LUA/functions")
require("data/mods/PoraComp/LUA/iuse_actions")
require("data/mods/PoraComp/LUA/coroutines")
require("data/mods/PoraComp/LUA/mop_actions")
require("data/mods/PoraComp/LUA/tk_izu")

local MOD = {
  id = "porawep",
  version = "2018-11-25"
}
mods[MOD.id] = MOD
DEBUG = false
para_chatter = 0
drop_pod_in_transit = false
close_fire_barrage_incoming = false

MOD.on_turn_passed = function()
	para_chatter = para_chatter + 1
	if g:is_in_sunlight(player:pos()) == true 
	and player:has_item_with_flag("SOLAR_CHARGE_5") then
		solar_reload()
	end
	if drop_pod_in_transit == true then
		coroutine.resume(co_drop_pod_landing)
	end
	if close_fire_barrage_incoming == true then
		coroutine.resume(co_tk_izu_close_fire_support)
		game.add_msg("<color_red>IMMEDIATE BARRAGE INCOMING</color>")
	end
end

MOD.on_day_passed = function()
	zygote_growth()
end
