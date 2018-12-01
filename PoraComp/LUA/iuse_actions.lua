function Zygote_Kit_IV_iuse()
	if player:has_effect(efftype_id("Fledgling_037")) == false
	and player:has_effect(efftype_id("PA_037_Zygote")) == false then
		local dur = DAYS(10000)
		player:add_effect(efftype_id("PA_037_Zygote"), dur)
	else
		game.add_msg("A deep feeling of dread approaches as you move the IV close to you arm... maybe another day.")
	end
end

function drop_pod_iuse(item) -- decodes the vars stuffed in drop pods to retrieve contents, check tk_izu.lua 's drop_pod_generation function 
	items_loaded = item:get_var("items_loaded", 0)
	
	for x = 1, (items_loaded) do
		-- Retreiving vars 
		local container_id_var = (x.."container")
		local item_id_var = (x.."name")
		local quantity_var = (x.."quantity")
		
		-- Assembling vars into usable values
		local content_container_item_id = item:get_var(container_id_var, "")
		local content_item_id = item:get_var(item_id_var, "")
		local content_quantity_string = item:get_var(quantity_var, 0)
		local content_quantity = tonumber(content_quantity_string)
		
		-- Taking values and assembling the item to be given, ensuring no charges are present
		local content = item(content_item_id, 0, content_quantity)
		if content:is_gun() == true then
			content.charges = 0
		end
		
		-- Checking if container is needed, and putting content inside
		if content_container_item_id ~= "no_container" then
			container = item(content_container_item_id, 1)
			for c = 1, content_quantity do
				container:fill_with(content)
			end
			player:i_add(container)
		else
			player:i_add(content) -- if container is not needed, just throw item into inventory
		end
	end
	
	-- Feedback message, transformation, and removal of vars, though the item transforms so it shouldn't effect anything anyways
	game.add_msg("<color_green>You twist the realese valve and the pod falls apart, revealing the contents!</color>")
	item:clear_vars()
	player:i_rem(item)
end

function tk_izu_connection_iuse()
	show_tk_izu_connection_menu()
end

function tk_izu_close_fire_support_iuse(item)
	
	co_tk_izu_close_fire_support = coroutine.create(function(item)
		
		-- Make a list of the position of every nearby monster.
		local beacon = item
		local center = player:pos()
		local targets = {}
		local active_targets = {}
		for off = 1, 40 do
			for x = -off, off do
				for y = -off, off do
				local z = 0 
					if math.abs(x) == off or math.abs(y) == off then
						local point = tripoint(center.x + x, center.y + y, center.z + z)
						local monster = g:critter_at(point)
						if monster then
							targets[#targets + 1] = monster:pos()
						end
					end
				end
			end
		end
		
		-- Fizz out beacon
		player:i_rem(beacon)
		game.add_msg("<color_red>The CFS beacon beeps a last high note, then fizzes out</color>")
		
		-- Choose 10 points at random from the list
		for n = 1, 13 do
			active_targets[#active_targets + 1] = targets[math.random(#targets)]
		end
		
		-- Wait then act on targets 1&2
		close_fire_barrage_incoming = true
		coroutine.yield()
		for t = 1, math.random(3,6) do
			coroutine.yield()
		end
		for o = 1, 2 do
			g:explosion(active_targets[o], 800)
		end
		
		-- Wait then act on targets 3-7
		for t = 1, math.random(2,7) do
			coroutine.yield()
		end
		for o = 3, 7 do
			g:explosion(active_targets[o], 800)
		end
		
		-- Wait then act on targets 8-10
		for t = 1, math.random(1,4) do
			coroutine.yield()
		end
		for o = 8, 10 do
			g:explosion(active_targets[o], 800)
		end
		
		-- Wait then act on targets 11-13
		for t = 1, math.random(2,7) do
			coroutine.yield()
		end
		for o = 11, 13 do
			g:explosion(active_targets[o], 800)
		end
		
		-- Close up the fireworks 
		close_fire_barrage_incoming = false
		
	end )
	
	coroutine.resume(co_tk_izu_close_fire_support, item)

end

game.register_iuse("Zygote_Kit_IV", Zygote_Kit_IV_iuse)
game.register_iuse("drop_pod", drop_pod_iuse)
game.register_iuse("tk_izu_connection", tk_izu_connection_iuse)
game.register_iuse("tk_izu_close_fire_support", tk_izu_close_fire_support_iuse)