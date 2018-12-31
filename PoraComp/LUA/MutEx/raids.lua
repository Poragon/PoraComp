-- Lists

-- Monsters nether raid spawns from (Order in ascending difficulty <3)
local nether_mongroups = {}

-- GROUP_NETHER
nether_mongroups[1] = {
[1] = "mon_flying_polyp",
[2] = "mon_hunting_horror",
[3] = "mon_mi_go",
[4] = "mon_yugg",
[5] = "mon_gelatin",
[6] = "mon_flaming_eye",
[7] = "mon_kreck",
[8] = "mon_gozu"
}


-- Monsters triffid raid spawns from (Order in ascending difficulty <3)
local triffid_mongroups = {}

-- GROUP_TRIFFID + changes
triffid_mongroups[1] = { 
[1] = "mon_triffid_young",
[2] = "mon_fungal_fighter",
[3] = "mon_vinebeast"
}

-- Monsters robot raid spawns from (Order in ascending difficulty <3)
local robot_mongroups = {}

-- GROUP_ROBOT + some changes
robot_mongroups[1] = {
[1] = "mon_skitterbot",
[2] = "mon_secubot",
[3] = "mon_copbot",
[4] = "mon_molebot",
[5] = "mon_tripod"
}

-- Monsters zombie raid spawns from (Order in ascending difficulty <3)
local zombie_mongroups = {}

-- GROUP_ZOMBIE 
zombie_mongroups[1] = {
[1] = "mon_zombie",
[2] = "mon_zombie_fat",
[3] = "mon_zombie_tough",
[4] = "mon_zombie_child",
[5] = "mon_zombie_rot",
[6] = "mon_zombie_crawler",
[7] = "mon_zombie_dog",
[8] = "mon_dog_skeleton",
[9] = "mon_dog_zombie_cop",
[10] = "mon_dog_zombie_rot",
[11] = "mon_zombie_soldier",
[12] = "mon_zombie_cop",
[13] = "mon_zombie_hazmat",
[14] = "mon_zombie_fireman",
[15] = "mon_zombie_grabber",
[16] = "mon_zombie_grappler",
[17] = "mon_zombie_hunter",
[18] = "mon_skeleton",
[19] = "mon_zombie_smoker",
[20] = "mon_zombie_grappler",
[21] = "mon_zombie_hunter",
[22] = "mon_zombie_smoker",
[23] = "mon_zombie_shady",
[24] = "mon_zombie_gasbag",
[25] = "mon_zombie_swimmer",
[26] = "mon_zombie_shrieker",
[27] = "mon_zombie_spitter",
[28] = "mon_zombie_acidic",
[29] = "mon_zombie_electric",
[30] = "mon_zombie_necro",
[31] = "mon_zombie_survivor",
[32] = "mon_boomer",
[33] = "mon_zombie_brute",
[34] = "mon_zombie_hulk",
[35] = "mon_skeleton_hulk",
[36] = "mon_zombie_master",
[37] = "mon_beekeeper",
[38] = "mon_zombie_technician",
[39] = "mon_zombie_brute_shocker",
[40] = "mon_zombie_runner"
}

--GROUP_ZOMBIE_MID
zombie_mongroups[2] = {
[1] = "mon_zombie",
[2] = "mon_zombie_fat",
[3] = "mon_zombie_tough",
[4] = "mon_zombie_anklebiter",
[5] = "mon_zombie_sproglodyte",
[6] = "mon_zombie_shriekling",
[7] = "mon_zombie_creepy",
[8] = "mon_zombie_snotgobbler",
[9] = "mon_zombie_waif",
[10] = "mon_zombie_child",
[11] = "mon_zombie_dog",
[12] = "mon_dog_skeleton",
[13] = "mon_dog_zombie_cop",
[14] = "mon_dog_zombie_rot",
[15] = "mon_zombie_soldier",
[16] = "mon_zombie_cop",
[17] = "mon_zombie_hazmat",
[18] = "mon_zombie_fireman",
[19] = "mon_zombie_grabber",
[20] = "mon_zombie_grappler",
[21] = "mon_zombie_hunter",
[22] = "mon_zombie_smoker",
[23] = "mon_zombie_shady",
[24] = "mon_zombie_gasbag",
[25] = "mon_zombie_swimmer",
[26] = "mon_zombie_shrieker",
[27] = "mon_zombie_spitter",
[28] = "mon_zombie_corrosive",
[29] = "mon_zombie_electric",
[30] = "mon_zombie_necro",
[31] = "mon_zombie_survivor",
[32] = "mon_boomer",
[33] = "mon_boomer_huge",
[34] = "mon_zombie_brute",
[35] = "mon_zombie_brute_ninja",
[36] = "mon_zombie_brute_grappler",
[37] = "mon_zombie_hulk",
[38] = "mon_skeleton_hulk",
[39] = "mon_zombie_master",
[40] = "mon_beekeeper",
[41] = "mon_zombie_technician",
[42] = "mon_zombie_brute_shocker",
[43] = "mon_zombie_hollow",
[44] = "mon_zombie_predator",
[45] = "mon_MutEx_zombie_brute",
[46] = "mon_MutEx_zombie_hollow",
[47] = "mon_MutEx_zombie_hulk",
[48] = "mon_MutEx_zombie_acidbag",
[49] = "mon_MutEx_zombie_echo",
[50] = "mon_MutEx_zombie_beserker"
}

-- Blurbs to send on an irregular basis when a nether raid is being prepared
local nether_warnings = {}
nether_warnings[1] = "<color_red>Sinister sensations send a shiver down your spine..."
nether_warnings[2] = "<color_red>A echoing cackle can be heard in the distance..."
nether_warnings[3] = "<color_red>Shadows flicker in your mind, forming unsettling pictures"

-- Blurbs to send on an irregular basis when a triffid raid is being prepared
local triffid_warnings = {}
triffid_warnings[1] = "<color_red>Plants sway vigorously... against the wind?"
triffid_warnings[2] = "<color_red>Patches of the ground seem unstable, as if recently upset"
triffid_warnings[3] = "<color_red>The shifting of the forest's leaves seems much louder today"

-- Blurbs to send on an irregular basis when a robot raid is being prepared
local robot_warnings = {}
robot_warnings[1] = "<color_red>A sort of soft hissing static seems to have settled in"

-- Blurbs to send on an irregular basis when a zombie raid is being prepared
local zombie_warnings = {}
zombie_warnings[1] = "<color_red>The cacophony of undead moans grows closer from the distance..."
zombie_warnings[2] = "<color_red>Though ever present, the reek of undead flesh overwhelms you"
zombie_warnings[3] = "<color_red>A car alarm rings out from far off"


-- Variables
local raid_chance_effect = efftype_id("raid_chance")
local raid_cooldown = efftype_id("raid_cooldown")
local waiting_for_raid = efftype_id("waiting_for_raid")
local nether_raid = efftype_id("nether_raid")
local triffid_raid = efftype_id("triffid_raid")
local robot_raid = efftype_id("robot_raid")
local zombie_raid = efftype_id("zombie_raid")
local base_level_points = 1 -- Sets point equivalence, eg. at 1, 1 pt = 1 standard zed. At 2, 1 pt = 2 standard zeds
local spawn_list = {}
local hours_till_raid = nil
local boss_raid = nil
local raid_difficulty = nil
local blurb_list = nil
local current_cooldown_days = nil
local mon_dodge = nil
local mon_armor_bash = nil
local mon_armor_cut = nil

-- Coroutines

-- Functions

-- Called daily to see if a raid should occur
function raid_roll()
	
	-- Checks to see if player has been in existence for more than the set days_till_raids_start, will never roll for raid if one is planned or active or the cooldown is active
	local player_age_days = player_get_age_days()
	
	if player_age_days >= days_till_raids_start and
	get_raid_faction() == false and
	player:has_effect(raid_cooldown) == false then
		
		-- Check if effect which stores raid chance exists, if not create it. Set raid chance to effect's int
		if player:has_effect(raid_chance_effect) == false then
			player:add_effect(raid_chance_effect, TURNS(1), "num_bp", true, 1)
		end
		local raid_chance = player:get_effect_int(raid_chance_effect)
		
		-- Raids start at 1% chance per day, growing at 1% per failed roll. Multiplied by raid frequency.
		if (raid_chance * raid_frequency) >= math.random(100) then
		raid_time_calculation()
		else
			player:add_effect(raid_chance_effect, TURNS(1), "num_bp", true, (raid_chance + 1))
		end
	end

end

-- Calculates out the time measure in # of hours till the raid should start.
function raid_time_calculation()

	-- Establish when these creatures will be coming. Later game characters get less prep time.
	local player_age_days = player_get_age_days()
	if player_age_days <= 62 then
		hours_till_raid = ( math.random(4, 8) * 24  + math.random(8, 18) )
	else
		hours_till_raid = ( math.random(2, 5) * 24 + math.random(3, 20) )
	end
	
	-- Run wait_for_raid()
	wait_for_raid(hours_till_raid)
	
end

-- Function which creates an effect to count down the hours till raid should occur. Faction type is also determined here to allow blurbs. Actual waiting is done by wait_for_raid_tick function
-- Input_hours_till_raid forces a specified wait time; int/float/long
function wait_for_raid(input_hours_till_raid)

	-- Checks if hours were input as an argument, if so overwrites hours till raid with the value
	if type(input_hours_till_raid) == "number" then
		hours_till_raid = input_hours_till_raid
	end

	-- Stores hours_till_raid in effect to avoid save/load issues. Also checks is effect exists, and does not edit it if so.
	if player:has_effect(waiting_for_raid) == false then
		player:add_effect(waiting_for_raid, HOURS(hours_till_raid))
	end
	
	-- Decides faction raid type, stored in effect to avoid save/load issues
	choose_raid_faction()
	
end

-- Does the waiting for wait_for_raid function. Called each hour if effect wait_for_raid is present. Also calls blurbs
function wait_for_raid_tick()

	if player:has_effect(waiting_for_raid) == false and
	get_raid_faction() ~= false then
		execute_raid_calculations()
		game.add_msg("calc")
	elseif player:has_effect(waiting_for_raid) == true and
	get_raid_faction() ~= false then
		raid_blurb()
	end
	
end

-- Calculates the needed info for execute_raid to function and hands it off
-- Boss argument forces boss raid; boolean
function execute_raid_calculations(boss)
	
	-- Roll chance for characters 100+ days old to trigger a boss raid
	local player_age_days = player_get_age_days()
	if player_age_days >= 100 then
		boss_raid_roll = math.random(100)
		if boss_raid_roll >= 90 then
			boss_raid = true
		end
	end
	
	-- Retrieve raid faction string from effect, chooses raid faction if waiting functions were skipped
	if get_raid_faction == false then
		choose_raid_faction()
	end
	local raid_faction = get_raid_faction()
	
	-- Checks if boss raid was input as argument, if so overwrites roll results
	if type(boss) == "boolean" then
		boss_raid = boss
	end
	
	-- Establish raid_strength, which will determine how strong the raid is. Again later game characters get more screwed.
	local raid_base_difficulty = player_get_age_days()
	local raid_modifier = raid_difficulty_option 
	if player:has_effect(efftype_id("attention")) == true then -- Attention effect forces nether faction raid type, doubles raid strength
		raid_modifier = raid_modifier + 1
		raid_faction = ("nether_faction")
	end
	raid_difficulty = ( (raid_base_difficulty * raid_modifier) * base_level_points ) -- Raid difficulty determines monster group choice and number of spawns
	
	-- Final hand off, sends the raid difficulty, raid faction, and if the raid is a boss raid to the execute_raid function
	execute_raid(raid_difficulty, raid_faction, boss_raid)
	
end

-- Executes the spawning of monsters with all the needed info
-- Input raid difficulty; int
-- Input raid faction determines monsters spawned; string
-- Input boss raid determines if boss raid; boolean
function execute_raid(input_raid_difficulty, input_raid_faction, input_boss_raid)

	-- Establish some variables
	local raid_difficulty = input_raid_difficulty
	local raid_faction = input_raid_faction
	local boss_raid = input_boss_raid
	
	-- First sets active spawn list to correct group, throw out a flavour message.
	if raid_faction == "nether_faction" then
		spawn_list = nether_mongroups
		game.add_msg("<color_red>A terrifying, pure evil washes over you. They're here.")
	elseif raid_faction == "triffid_faction" then
		spawn_list = triffid_mongroups
		game.add_msg("<color_red>Roots erupt from the ground and wood creaks. Mother nature has her target.")
	elseif raid_faction == "robot_faction" then
		spawn_list = robot_mongroups
		game.add_msg("<color_red>Mechanical whirs fill the air, man's machanations are not allies today.")
	else
		spawn_list = zombie_mongroups
		game.add_msg("<color_red>A chorous of undead screams pierces the area, and the telltale sounds of a horde come soon after...")
	end
	
	-- Begin the spawns~!
	-- Establishing list of possible landing spots... I mean totally not ripping code from tk_izu
	-- Actually looks for all tiles the player cannot see that are at least 60 tiles away (reality bubble edge is 66 tiles away)
	-- Loops and spawns until all points are spent. Will go into negitives to give player a big last suprise
	repeat
	
	local possible_spawn_pos = {}
	local center = player:pos()
	for off = 55, 60 do
		for x = -off, off do
			for y = -off, off do
			local z = 0 
				if math.abs(x) == off or math.abs(y) == off then
					local point = tripoint(center.x + x, center.y + y, center.z + z)
					if player:sees(point) ~= true and
					game.get_monster_at(point) == nil then
						possible_spawn_pos[#possible_spawn_pos + 1] = point
					end
				end
			end
		end
	end
	
	-- Pick a random spot from the avalible 
	local location_key = math.random(#possible_spawn_pos)
	local spawn_location = possible_spawn_pos[location_key]
	local spawn_key = 1
	
	-- Determines which monstergroup to pull from the active spawn list, based off difficulty of raid
	if #spawn_list > 2 then
		spawn_key = math.ceil(raid_difficulty / raid_group_threshold)
		if spawn_key > #spawn_list then
			spawn_key = #spawn_list
		end
	end
	local mon_key = math.random(#spawn_list[spawn_key])
	local mon_spawn = mtype_id(spawn_list[spawn_key][mon_key])
	
	-- Spawn the monster itself and calculate its difficulty from stats
	local mon = g:summon_mon(mon_spawn, spawn_location)
	if mon ~= nil then
		
		-- Ensure values actually exist before pulling, avoiding errors
		if mon:get_dodge() ~= nil then
			mon_dodge = mon:get_dodge()
		else
			mon_dodge = 0
		end
		
		if mon:get_armor_bash("num_bp") ~= nil then
			mon_armor_bash = mon:get_armor_bash("num_bp")
		else
			mon_armor_bash = 0
		end
		
		if mon:get_armor_cut("num_bp") ~= nil then
			mon_armor_cut = mon:get_armor_cut("num_bp")
		else
			mon_armor_cut = 0
		end
		
		-- Calculate out monster difficulty, subtract from raid total
		local offensive_base = ( (1 + mon:get_melee() ) * 0.08 )
		local defense_base = ( ( 1 + mon_dodge ) * ( ( 2 + ( mon_armor_bash + mon_armor_cut ) ) / 25 ) )
		local hp_base = ( mon:get_hp() / 100 )
		local monster_difficulty = offensive_base + defense_base + hp_base
		raid_difficulty = raid_difficulty - monster_difficulty
		
		-- Give the monster a loving push in the player's direction
		mon:wander_to(player:pos(), 200)
		
	end
	
	until raid_difficulty <= 0 or #possible_spawn_pos == 0
	
	-- Wraping up things, setting values back to nil that need to be
	player:remove_effect(nether_raid)
	player:remove_effect(triffid_raid)
	player:remove_effect(robot_raid)
	player:remove_effect(zombie_raid)
	player:remove_effect(raid_chance_effect)
	raid_faction = false
	hours_till_raid = nil
	boss_raid = nil
	raid_difficulty = nil
	mon_dodge = nil
	mon_armor_bash = nil
	mon_armor_cut = nil
	spawn_list = {}
	
	-- Adds a cooldown of 3-5 days to prevent back to back raids; anything that creates raids and bypasses the raid_roll ignores this cooldown, but will reset it.
	local cooldown_days = math.random(3, 5)
	player:add_effect(raid_cooldown, TURNS(1), "num_bp", true, cooldown_days)
	

end

-- Ticks down the raid cooldown effect each day by one
function raid_cooldown_tick()

	current_cooldown_days = player:get_effect_int(raid_cooldown)
	if current_cooldown_days == 0 then
		player:remove_effect(raid_cooldown)
	else
		player:add_effect(raid_cooldown, TURNS(1), "num_bp", (current_cooldown_days - 1))
	end
	
end


	
-- Sends out a message to warn players of incoming raid, adds flavour
function raid_blurb()

	-- Roll to send a blurb, roll is done once an hour
	blurb_roll = math.random(10)

	if blurb_roll >= 9 then
	
		-- Fetch the current raid faction
		local faction = get_raid_faction() -- variable should never be named raid faction, will cause double raids >.>
		
		-- Select which list the blurb will draw from
		if faction == "nether_faction" then
			blurb_list = nether_warnings
		elseif faction == "triffid_faction" then
			blurb_list = triffid_warnings
		elseif faction == "robot_faction" then
			blurb_list = robot_warnings
		else
			blurb_list = zombie_warnings
		end

		-- Sends the blurb via game.add_msg()
		local blurb_choice = blurb_list[math.random(#blurb_list)]
		game.add_msg(blurb_choice)
		
	end
	
end

-- Adds an effect which effectively stores a string to decide raid faction
function choose_raid_faction()

	local raid_faction_roll = math.random(10)
	if raid_faction_roll == 10 then
		player:add_effect(nether_raid, TURNS(1), "num_bp", true)
	elseif raid_faction_roll == 9 then
		player:add_effect(triffid_raid, TURNS(1), "num_bp", true)
	elseif raid_faction_roll == 8 then
		player:add_effect(robot_raid, TURNS(1), "num_bp", true)
	elseif raid_faction_roll < 8 then
		player:add_effect(zombie_raid, TURNS(1), "num_bp", true)
	end
	
end

-- Retrieves faction string needed for functions from stored effect, in the case of anything gone wrong defaults to zed
function get_raid_faction()
	
	local faction = false
	
	if player:has_effect(nether_raid) == true then
		faction = "nether_faction"
	elseif player:has_effect(triffid_raid) == true then
		faction = "triffid_faction"
	elseif player:has_effect(robot_raid) == true then
		faction = "robot_faction"
	elseif player:has_effect(zombie_raid) == true then
		faction = "zombie_raid"
	end
	
	return(faction)
	
end