function creature_distance_from_player(Creature)
	local mpoint = Creature:pos() 
	local ppoint = player:pos()
	local distance_to_player = math.sqrt( ((mpoint.x - ppoint.x)^2) + ((mpoint.y - ppoint.y)^2) )
	return distance_to_player
end

function monster_update()
	local center = player:pos()
	for off = 1, 60 do
		for x = -off, off do
			for y = -off, off do
			local z = 0 
				if math.abs(x) == off or math.abs(y) == off then
					local point = tripoint(center.x + x, center.y + y, center.z + z)
					local monster = g:critter_at(point)
						if monster then
							mon_update_tick(monster)
						end
				end
			end
		end
	end
end

function mon_update_tick(monster)
	if monster:get_name() == "Beserker" then
		local monhp = monster:get_hp()
		local monhpmax = monster:get_hp_max()
		local hp_armor_multiplier = monhp / monhpmax 
		local beserker_armor_cut = 100
		local beserker_armor_bash = 50
		monster:set_armor_bash_bonus(beserker_armor_bash * hp_armor_multiplier)
		monster:set_armor_cut_bonus(beserker_armor_cut * hp_armor_multiplier)
	end
end