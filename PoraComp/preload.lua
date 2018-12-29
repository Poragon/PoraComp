-- Options

-- MutEx Options
days_till_raids_start = 31 -- Raids will not occur until this number of days have passed since mod install
raid_difficulty_option = 1 -- Higher humber means harder raids
raid_frequency = 1 -- Higher number means more frequent raids
raid_group_threshold = 100 -- Threshold for what difficulty allow raids to climb into the next tier of monstergroup


--Preload Stuff

package.path = package.path .. ";/storage/emulated/0/Android/data/com.cleverraven.cataclysmdda/files/?.lua" --Android
package.path = package.path .. ";/storage/sdcard/Android/data/com.cleverraven.cataclysmdda/files/?.lua" --Android (SD Card)
package.path = package.path .. ";/storage/sdcard0/Android/data/com.cleverraven.cataclysmdda/files/?.lua" --Android (SD Card 0)
package.path = package.path .. ";/storage/sdcard1/Android/data/com.cleverraven.cataclysmdda/files/?.lua" --Android (SD Card 1)
package.path = package.path .. ";./?.pora" 

require("data/mods/PoraComp/LUA/MutEx/monster_attacks")
require("data/mods/PoraComp/LUA/MutEx/raids")
require("data/mods/PoraComp/LUA/BioCo/iuse_actions")
require("data/mods/PoraComp/LUA/BioCo/tk_izu")
require("data/mods/PoraComp/LUA/BioCo/parasite")
require("data/mods/PoraComp/LUA/MopActions/mop_actions")
require("data/mods/PoraComp/LUA/DynamicCooking/dynamic_cooking")
require("data/mods/PoraComp/LUA/DynamicCooking/iuse_actions")
require("data/mods/PoraComp/LUA/functions")
require("data/mods/PoraComp/LUA/test_functions")
require("data/mods/PoraComp/LUA/DirtyCata/dirty_cata")
require("data/mods/PoraComp/LUA/DirtyCata/iuse_actions")
require("data/mods/PoraComp/LUA/Lipids/lipids")

local MOD = {
  id = "porawep",
  version = "2018-11-25"
}

-- Variables

mods[MOD.id] = MOD
DEBUG = false
para_chatter = 0
drop_pod_in_transit = false
close_fire_barrage_incoming = false

-- Coroutines

-- Functions

MOD.on_turn_passed = function()
	
	-- Shared on time calls
	if g:is_in_sunlight(player:pos()) == true 
	and player:has_item_with_flag("SOLAR_CHARGE_5") then
		solar_reload()
	end
	
	-- BioCo shared on time calls
	para_chatter = para_chatter + 1
	if drop_pod_in_transit == true then
		coroutine.resume(co_drop_pod_landing)
	end
	if close_fire_barrage_incoming == true then
		coroutine.resume(co_tk_izu_close_fire_support)
		game.add_msg("<color_red>IMMEDIATE BARRAGE INCOMING</color>")
	end

end

MOD.on_minute_passed = function()

	-- Lipids shared on time calls
	fat_reserve_process()

end

MOD.on_hour_passed = function()

	-- MutEx shared on time calls
	wait_for_raid_tick()

end

MOD.on_day_passed = function()

	-- Shared on time calls
	age_one_day()
	
	-- BioCo shared on time calls
	zygote_growth()

	
	-- MutEx shared on time calls
	raid_roll()
	if player:has_effect(efftype_id("raid_cooldown")) == true then
		raid_cooldown_tick()
	end

end

MOD.on_savegame_loaded = function()

	-- Lipids on load calls
	if player:has_effect(efftype_id("fat_reserves")) == false then
		player:add_effect(efftype_id("fat_reserves"), TURNS(1), "bp_torso", true, 10000)
	end

end