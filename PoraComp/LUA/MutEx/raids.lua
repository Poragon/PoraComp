-- Lists



-- Variables
local raid_cooldown = efftype_id("raid_cooldown")
raid_chance = 1

-- Coroutines

-- Functions

function raid_roll()
	
	-- Checks to see if player has been in existence for more than the set days_till_raids_start
	local player_age_days = get_player_age_days()
	if player_age_days >= days_till_raids_start then
		
		-- Raids start at 1% chance per day, growing at 1% per failed roll. Multiplied by raid frequency.
		if (raid_chance * raid_frequency) >= math.random(100) then
			local raid_faction_roll = math.random(10)
			if raid_faction_roll == 10 then
				local raid_faction = ("nether_faction")
			elseif raid_faction_roll == 9 then
				local raid_faction = ("triffid_faction")
			elseif raid_faction_roll == 8 then
				local raid_faction = ("robot_faction")
			else
				local raid_faction = ("zombie_faction")
			end
		raid_calculation(raid_faction, player_age_days)
		else
			raid_chance = raid_chance + 1
		end
	end

end

function raid_calculation(raid_faction, player_age_days)

	-- Establish when these creatures will be coming. Later game characters get less prep time.
	if player_age_days <= 62 then
		local days_till_raid = math.random(4, 8)
	else 
		local days_till_raid = math.random(2, 5)
	end
	
	-- Establish raid_strength, which will determine how strong the raid is. Again later game characters get more screwed.
	local raid_strength_base = player_age_days -- Strength number is amount of standard zeds in equivalent
	local raid_modifier = raid_difficulty
	if player:has_effect(efftype_id("attention")) == true then -- Attention effect forces nether faction raid type, doubles raid strength
		local raid_modifier = raid_modifier + 1
		local raid_faction = "nether_faction"
	end
	
end
	
	
	
