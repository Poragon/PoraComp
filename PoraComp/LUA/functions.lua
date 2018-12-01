function creature_distance_from_player(target)
	local mpoint = target:pos() 
	local ppoint = player:pos()
	local distance_to_player = math.sqrt( ((mpoint.x - ppoint.x)^2) + ((mpoint.y - ppoint.y)^2) )
	return distance_to_player
end

function monsters_around()
	local center = player:pos()
	for off = 1, 60 do
		for x = -off, off do
			for y = -off, off do
			local z = 0 
				if math.abs(x) == off or math.abs(y) == off then
					local point = tripoint(center.x + x, center.y + y, center.z + z)
					local monster = g:critter_at(point)
						if monster then
							return monster
						end
				end
			end
		end
	end
end

function monster_update_tick(monster)
	if DEBUG == true then 
		game.add_msg("Update called for: "..monster:get_name()) 
	end
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

function monster_heal_1of10(monster)
	local ran = 2
	if ran == 2 then
		local monhpmax = monster:get_hp_max() 
		local monhp = monster:get_hp()
		local monhp_mod = monhpmax * 0.2
		if monhp + monhp_mod < monhpmax then
			monster:set_hp( monhp + monhp_mod )
		end
	end
end

function speed_distortion(Creature)
	local ran = math.random(5)
	local dur = math.random(10,20)
	local dur_turns = TURNS(dur)
	if ran == 1 then
		Creature:add_effect(efftype_id("speed_distortion_terrible"), dur_turns)
	elseif ran == 2 then
		Creature:add_effect(efftype_id("speed_distortion_bad"), dur_turns)
	elseif ran == 3 then
		return
	elseif ran == 4 then
		Creature:add_effect(efftype_id("speed_distortion_good"), dur_turns)
	elseif ran == 5 then
		Creature:add_effect(efftype_id("speed_distortion_great"), dur_turns)
	end
end

function monster_attention(monster)
	local point_base = player:pos()
	local offset = math.random(4) - math.random(7)
	local point = tripoint(point_base.x + offset, point_base.y + offset, point_base.z)
	monster:set_dest(point)
end

function solar_reload()
	for x = 0, 100 do --Will break once 100+ items in inventory
		local item = search_inventory(x)
		if item:has_flag("SOLAR_CHARGE_5") == true then --.json flag to help keep things in check
			if item:has_var("solar_charges") == true then
				local solar_charges_string = item:get_var("solar_charges", 0)
				local solar_charges_int = tonumber(solar_charges_string)
				if solar_charges_int >= 5 then --Check here determines # of turns till charge gained
					item:set_var("solar_charges", 0)
					local ammo_count = item.charges
					if ammo_count  < item:ammo_capacity() then
						item.charges = ammo_count + 1
					end
				else
				base = item:get_var("solar_charges", 0)
				item:set_var("solar_charges", base + 1)
				end
			else
				item:set_var("solar_charges", 1)
			end
		end
	end
end

function search_inventory(int)
	local item = player:i_at(int)
	return item
end

function zygote_growth()
	if player:has_effect(efftype_id("PA_037_Zygote")) == true then
		local dur_mod = DAYS(2)
		player:add_effect(efftype_id("PA_037_Zygote"), dur_mod)
		coroutine.resume(zygote_growth_count)
	end
end

function parasite_sense_danger(monster)
	if player:has_effect(efftype_id("Fledgling_037")) == true
	and para_chatter > 100 then
		if monster:get_name() == "Beserker"
		or monster:get_name() == "Echo" then 
			local fledgling_danger = {}
				fledgling_danger[1] = "<color_magenta>...near, strong...</color>"
				fledgling_danger[2] = "<color_magenta>struggle... soon...</color>"
				fledgling_danger[3] = "<color_magenta>...others?</color>"
				fledgling_danger[4] = "<color_magenta>run... far...</color>"
			local danger_statement = fledgling_danger[math.random(4)]
			game.add_msg(danger_statement)
			para_chatter = 0
		end
	end
end