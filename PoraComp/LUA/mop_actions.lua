local Mop_Menu
local Mop_MenuEntries
local Container_Menu
local Container_Menu_Entries

function Create_Mop_Menu()

    Mop_MenuEntries = {
        [ 0 ] = { [ 0 ] = nil, [ 1 ] = "Cancel mopping" }
    }

    Mop_Menu = game.create_uimenu()
    Mop_Menu.title = "Select target for mopping"
    Mop_Menu:addentry( "<color_light_red>Cancel mopping</color>" )

end

function Create_Container_Menu()
	
	Container_Menu_Entries = {
		[ 0 ] = { [ 0 ] = nil, [ 1 ] = "Cancel container" }
	
	}
	Container_Menu = game.create_uimenu()
	Container_Menu.title = "Select container for liquid"
	Container_Menu:addentry("<color_light_red>Cancel mopping</color>")
end

function Show_Container_Menu(liquid_item, liquid_item_pos )
	
	Create_Container_Menu()
	
	for x = 0, 1000 do
		local inv_entry = player:i_at(x)
		if inv_entry:is_container_full() == false
		and inv_entry:is_watertight_container() == true then
			local container_space = inv_entry:get_remaining_capacity_for_liquid(liquid_item, false)
			if container_space >= liquid_item.charges  then
				remove_entirely = true
				Container_Menu_Entries[ #Container_Menu_Entries + 1 ] = inv_entry
				local container_menu_entry = string.format("Use %s", inv_entry:display_name())
				Container_Menu:addentry( container_menu_entry )
			elseif container_space < liquid_item.charges
			and container_space ~= 0 then
				remove_entirely = false
				Container_Menu_Entries[ #Container_Menu_Entries + 1 ] = inv_entry
				local container_menu_entry = string.format("Use %s", inv_entry:display_name())
				Container_Menu:addentry( container_menu_entry )
			end
		end
	end
	
	if ( #Container_Menu_Entries >= 1 ) then
		Container_Menu:show()
		Container_Menu:query(true)
		local container_choice = Container_Menu.selected
		if container_choice == 0 then
			game.add_msg( "You decided not to mop anything." )
		else
			container = Container_Menu_Entries[container_choice]
			mop_spilled_liquid_from_tripoint( liquid_item, liquid_item_pos, container, container_space )
		end
	else
	game.add_msg("No valid container in inventory to put liquid in.")
	end 
	
end

function Show_Mop_Menu( mopping_center, mopping_radius, container )

    Create_Mop_Menu()

    local mopping_points = {}
    if( math.abs( mopping_radius ) > 0 ) then
        for x = -mopping_radius, mopping_radius do
            for y = -mopping_radius, mopping_radius do
                local mopping_point = tripoint( mopping_center.x + x, mopping_center.y + y, mopping_center.z + 0 )
                local mopping_distance = game.trig_dist( mopping_point.x, mopping_point.y, mopping_center.x, mopping_center.y )
                if( mopping_distance <= mopping_radius ) then
                    mopping_points[ #mopping_points + 1 ] = mopping_point
                end
            end
        end
    else
        mopping_points[ #mopping_points + 1 ] = mopping_center
    end

    for _,v in ipairs( mopping_points ) do
        item_tripoint = v
        if map:i_at( item_tripoint ):size() > 0 then
            local item_stack_iterator =  map:i_at( item_tripoint ):cppbegin()
            for _ = 1, map:i_at( item_tripoint ):size() do
                local item = item_stack_iterator:elem()
                if( item.type.phase == "LIQUID" ) then
                    Mop_MenuEntries[ #Mop_MenuEntries + 1 ] = { [ 0 ] = item, [ 1 ] = item_tripoint }
                    local menu_entry = string.format( "Mop %s", item:display_name() )
                    Mop_Menu:addentry( menu_entry )
                end
                item_stack_iterator:inc()
            end
        end
    end
	
	if( #Mop_MenuEntries >= 1 ) then
		Mop_Menu:show()
		Mop_Menu:query( true )
		local choice = Mop_Menu.selected
		if choice == 0 then
			game.add_msg( "You decided not to mop anything." )
		else
			liquid_item =  Mop_MenuEntries[choice][0]
			liquid_item_pos = Mop_MenuEntries[choice][1]
			Show_Container_Menu( liquid_item, liquid_item_pos )
		end
	else
		game.add_msg( "There are no liquids to mop." )
	end
	
end


function mop_spilled_liquid_from_tripoint( liquid_item, liquid_tripoint, container, container_space )
	
	local liquid_name = tostring( liquid_item:display_name() )
	container:fill_with( liquid_item ) --Add liquid to container
	if remove_entirely == true then
		map:i_rem( liquid_tripoint, liquid_item ) --Remove liquid from map
		game.add_msg("You wipe the "..liquid_name.." from the floor.")
	else
		game.add_msg("You wipe the "..liquid_name.." from the floor, but some still remains.")
		liquid_item.charges = liquid_item.charges - container_space
		
	end

end

function mop_spilled_liquid_v1( item, active ) --Adjacent one tile radius circle around player with following menu selection

    local center_tripoint = player:pos()
    Show_Mop_Menu( center_tripoint, 1 )

end

function mop_spilled_liquid_v2( item, active ) --Adjacent tile in direction with cursor keys with following menu selection

    local setx, sety = game.choose_adjacent( "Select target for mopping", player:posx(), player:posy() )
    local setz = player:posz()

    local center_tripoint = tripoint( setx, sety, setz )
    Show_Mop_Menu( center_tripoint, 0 )

end

    game.register_iuse( "IUSE_MOP_SPILLED_LIQUID_V1", mop_spilled_liquid_v1 )
    game.register_iuse( "IUSE_MOP_SPILLED_LIQUID_V2", mop_spilled_liquid_v2 )