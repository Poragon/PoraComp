-- Variables

-- Coroutines

-- Functions

function creature_distance_from_player(target)
	local mpoint = target:pos() 
	local ppoint = player:pos()
	local distance_to_player = math.sqrt( ((mpoint.x - ppoint.x)^2) + ((mpoint.y - ppoint.y)^2) )
	return distance_to_player
end

function search_inventory(int)
	local item = player:i_at(int)
	return item
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