-- Variables

-- Coroutines

-- Functions

function disease_check()

	-- Set up variables used in function
	local player_health = player:get_healthy()
	local cooking_skill = player:get_skill_level("cooking")
	
-- Begin check for valid diseases, roll chance to apply
	
	-- Oppertunistic diseases, appear with lower than 0 health
	if player_health < 0 then 
	end
	
	-- Specific diseases, occur with unique circumstances
	
	-- Hygeine diseases, occur with low hygeine
	
end