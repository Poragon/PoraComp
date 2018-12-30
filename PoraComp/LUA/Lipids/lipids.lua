-- Quick notes 
-- Fat amount is stored in the effect fat_reserves' intensity.
-- Ranges for weight effects are based upon an ideal fat percentage of 10 - 16.5% body weight and a weight of 62kg
-- Ranges thusly are as follows (format is fat intensity(weight in kg), with 1 intensity of fat being 1g of fat);
-- 1 (1g minimum_fat) - extremely underweight - 2170(2.17kg) - underweight - 6200(6.2kg) - ideal range - 10230(10.23kg) - overweight - 14260(14.26kg) - extremely overweight - 18290(18.29kg) - obesity - 20000(20kg maximum_fat)

-- Variables
local fat_reserves = efftype_id("fat_reserves")
local extremely_underweight = efftype_id("extremely_underweight")
local underweight = efftype_id("underweight")
local ideal_weight = efftype_id("ideal_weight")
local overweight = efftype_id("overweight")
local extremely_overweight = efftype_id("extremely_overweight")
local obesity = efftype_id("obesity")

-- Coroutines

-- Functions

function fat_reserve_process()

	-- Check is player has the fat effect, if not set player to default starting fat
	if player:has_effect(fat_reserves) == false then
		player:add_effect(fat_reserves, TURNS(1), "bp_torso", true, starting_fat)
	end

	-- Set up some variables each time called
	local player_hunger = player:get_hunger()
	local current_fat = player:get_effect_int(fat_reserves, "bp_torso") 
	local minimum_fat = 1
	local maximum_fat = 20000
	local chance_1of5 = math.random(5)
	new_fat_value = current_fat
	
	-- Compares hunger a minute ago to current hunger. For every hunger value below 20 one point of hunger is converted to one level of fat intensity 33% of the time.
	if player_hunger_old == nil then
		player_hunger_old = player_hunger
		return
	elseif player_hunger < 20 and
	current_fat <= maximum_fat and
	chance_1of5 == 5 then
		new_fat_value = current_fat + 1
		player:set_hunger(player_hunger + 1)
	end
	
	-- Draws from fat reserves when hunger gets above 45 to set it back to 45. 1:1 fat to hunger reduction, so one fat intensity is 9.7 kcal or just about 1.1g
	if player_hunger > 45 and
	current_fat > minimum_fat then
		local hunger_mod = ( player_hunger - 45 )
		if current_fat > hunger_mod then
			new_fat_value = ( current_fat - hunger_mod )
			player:set_hunger( player_hunger - hunger_mod )
		elseif current_fat <= hunger_mod then
			new_fat_value = ( 1 )
			player:set_hunger( player_hunger + ( 1 - current_fat ) )
		end
	end
	
	-- Updates fat value, sets player_hunger_old again to prevent issues with hunger going negitive
	player:add_effect(fat_reserves, TURNS(1), "bp_torso", true, new_fat_value)
	player_hunger_old = player_hunger
	
	-- Updates current_fat, removes existing fat effects, applies effects based upon fat count 
	if player:has_effect(extremely_underweight) == true then
		player:remove_effect(extremely_underweight)
	elseif player:has_effect(underweight) == true then
		player:remove_effect(underweight)
	elseif player:has_effect(ideal_weight) == true then
		player:remove_effect(ideal_weight)
	elseif player:has_effect(overweight) == true then
		player:remove_effect(overweight)
	elseif player:has_effect(extremely_overweight) == true then
		player:remove_effect(extremely_overweight)
	elseif player:has_effect(obesity) == true then
		player:remove_effect(obesity)
	end
	
	if current_fat < 2170 then
		player:add_effect(extremely_underweight, TURNS(1), "num_bp", true)
	elseif current_fat >= 2170 and
	current_fat < 6200 then
		player:add_effect(underweight, TURNS(1), "num_bp", true)
	elseif current_fat >= 6200 and
	current_fat < 10230 then
		player:add_effect(ideal_weight, TURNS(1), "num_bp", true)
	elseif current_fat >= 10230 and
	current_fat < 14260 then
		player:add_effect(overweight, TURNS(1), "num_bp", true)
	elseif current_fat >= 14260 and
	current_fat < 18290 then
		player:add_effect(extremely_overweight, TURNS(1), "num_bp", true)
	else
		player:add_effect(obesity, TURNS(1), "num_bp", true)
	end

end