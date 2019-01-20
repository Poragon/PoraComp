-- Variables

-- Coroutines

-- Functions

function test_var(varname)

	for x = 0, 100 do --Will break once 100+ items in inventory, searches for valid security keys and adds them to list
		local item = search_inventory(x)
		local entry = item:get_var(varname, 0)
		game.add_msg("int "..entry)
	end

end

function test_place_spawns(monster_group_id, chance, density)
	
	-- Establish some variables
	local monster_group = mongroup_id(monster_group_id)
	local center = player:pos()
	local direction_roll = math.random(4)
	
	-- Choose direction to shove all the zeds
	if direction_roll == 1 then
		map:place_spawns(monster_group, chance, center.x + 70, center.y + 70, center.x + 75, center.y + 75, density)
	elseif direction_roll == 2 then
		map:place_spawns(monster_group, chance, center.x + 75, center.y -75, center.x + 75, center.y - 75, density)
	elseif direction_roll == 3 then
		map:place_spawns(monster_group, chance, center.x - 75, center.y +75, center.x - 75, center.y + 75, density)
	else
		map:place_spawns(monster_group, chance, center.x -75, center.y -75, center.x - 75, center.y - 75, density)
	end
	
end

function current_coord()

	local center = player:pos()
	game.add_msg(center.x.." "..center.y.." "..center.z)
	
end

-- Lipids test functions
function current_fat()

	local fat_reserves = efftype_id("fat_reserves")
	local current_fat = player:get_effect_int(fat_reserves, "bp_torso") 
	
	game.add_msg("Current fat is :"..current_fat)
	game.add_msg("Current hunger is :"..player:get_hunger())
	
end