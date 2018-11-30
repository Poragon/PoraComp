-- ui locals, don't actually know if needed
local tk_izu_connection_menu
local commissary_selection_menu
local register_security_key_menu
local supply_selection_menu
local supply_selection_menu_entries
local insufficent_funds_menu
local drop_pod_in_transit_menu
local permission_denied_menu

-- constants
supply_list = {}
items_to_load = 0

-- Supply Lists format:
-- supplylist[x] = { [0] = "container item_id" or "no_container", [ 1 ] = "item_id", [ 2 ] = quantity, [ 3 ] = price in cents, [ 4 ] = (optional) security clearance }
-- security clearences; "BioCo_Logistics_Department", "BioCo_Research_Lead", "BioCo_Field_Op"
field_agent_supply_list = {}
field_agent_supply_list[1] = { [ 0 ] = "no_container", [ 1 ] = "MagTech_Revolving_Rifle_6kJ", [ 2 ] = 1, [ 3 ] = 1500000, [ 4 ] = "Security_Key_Field_Op" }
field_agent_supply_list[2] = { [ 0 ] = "no_container", [ 1 ] = "XE037_Emergency_Injection", [ 2 ] = 5, [ 3 ] = 90000, [ 4 ] = "Security_Key_Field_Op" }
field_agent_supply_list[3] = { [ 0 ] = "no_container", [ 1 ] = "T.K_Izu_Close_Fire_Support_Beacon", [ 2 ] = 1, [ 3 ] = 900000, [ 4 ] = "Security_Key_Field_Op" }

common_supply_list = {}
common_supply_list[1] = { [ 0 ] = "BioCo_Atmospheric_Splash_Pack", [ 1 ] = "BioCo_Crude_Chemical_Precursor", [ 2 ] = 5, [ 3 ] = 500000, [ 4 ] = "Security_Key_Logistics" }
common_supply_list[2] = { [ 0 ] = "BioCo_Atmospheric_Splash_Pack", [ 1 ] = "BioCo_Chemical_Precursor", [ 2 ] = 3, [ 3 ] = 600000, [ 4 ] = "Security_Key_Logistics" }
common_supply_list[3] = { [ 0 ] = "BioCo_Atmospheric_Splash_Pack", [ 1 ] = "BioCo_Fine_Chemical_Precursor", [ 2 ] = 1, [ 3 ] = 900000, [ 4 ] = "Security_Key_Logistics" }
common_supply_list[4] = { [ 0 ] = "no_container", [ 1 ] = "Pristine_Bionic_Components", [ 2 ] = 3, [ 3 ] = 500000, [ 4 ] = "Security_Key_Logistics" }
common_supply_list[5] = { [ 0 ] = "no_container", [ 1 ] = "BioCo_Food_Bar", [ 2 ] = 10, [ 3 ] = 500000, [ 4 ] = "Security_Key_Logistics" }

-- Current Purchases format:
-- current_purchases[x] = { [0] = (optional) container item_id or nil, [ 1 ] = "item_id", [ 2 ] = quantity }
current_purchases = {}

-- Supply Lists list format:
-- supply_lists_list [x] = { [ 0 ] = some_supply_list, [ 1 ] = "supply_list_display_name" }
supply_lists_list = {}
supply_lists_list[1] = { [ 0 ] = field_agent_supply_list, [ 1 ] = "Field Agent Requests" }
supply_lists_list[2] = { [ 0 ] = common_supply_list, [ 1 ] = "Common Supplies" }

-- UI Create Functions; defines framework that show functions use
function create_tk_izu_connection_menu()

	tk_izu_connection_menu = game.create_uimenu()
	tk_izu_connection_menu.title = "Welcome to the T.K Izu Connection Interface"
	tk_izu_connection_menu:addentry ( "Shut Down T.K Izu Connection Interface" )
	
	-- Few entry's should be in this root menu, so they are listed manually
	
	tk_izu_connection_menu:addentry ( "Register New Security key" )
	tk_izu_connection_menu:addentry ( "Access Commissary Modules" )
	
end

function create_register_security_key_menu()

	register_security_key_menu = game.create_uimenu()
	register_security_key_menu.title = "Please Select a Security Key"
	register_security_key_menu:addentry ( "Cancel Registry" )

end
	
function create_commissary_selection_menu()

	commissary_selection_menu = game.create_uimenu()
	commissary_selection_menu.title = "Select Commissary Module"
	commissary_selection_menu:addentry ( "Cancel Commissary Selection" )
	
end

function create_supply_selection_menu()

    supply_selection_menu_entries = {
        [ 0 ] = { [ 0 ] = nil, [ 1 ] = "Finish Selection" }
    }

    supply_selection_menu = game.create_uimenu()
	local account_balance = math.floor(player.cash / 100)
	local account_balance_title = ("Account Balance: $"..account_balance)
    supply_selection_menu.title = account_balance_title
	if #current_purchases < 1 then
		supply_selection_menu:addentry( "Cancel Selection" )
	else
		supply_selection_menu:addentry( "Finish Selection" )
	end

end

function create_insufficent_funds_menu()

    insufficent_funds_menu = game.create_uimenu()
    insufficent_funds_menu.title = "Purchase Failed"
	insufficent_funds_menu:addentry( "Insufficent Funds in Account" )

end

function create_drop_pod_in_transit_menu()

    drop_pod_in_transit_menu = game.create_uimenu()
    drop_pod_in_transit_menu.title = "ERROR; DROP POD IN TRANSIT"
	drop_pod_in_transit_menu:addentry( "Drop Pod Already in Transit" )

end

function create_permission_denied_menu()

    permission_denied_menu = game.create_uimenu()
    permission_denied_menu.title = "ERROR; COMISSARY PERMISSION DENIED"
	permission_denied_menu:addentry( "Security Clearance Not Found" )

end

-- UI show functions; draws the UI out and defines the flesh of it
function show_tk_izu_connection_menu()

	create_tk_izu_connection_menu()
	
	tk_izu_connection_menu:show()
	tk_izu_connection_menu:query(true)
	
	local choice = tk_izu_connection_menu.selected
	if choice == 0 then
		game.add_msg("You terminate the connection to T.K Izu")
	elseif choice == 1 then
		show_register_security_key_menu()
	elseif choice == 2 then
		if drop_pod_in_transit == false then
			show_commissary_selection_menu()
		else
			show_drop_pod_in_transit_menu()
		end
	end

end

function show_register_security_key_menu()

	create_register_security_key_menu()
	local security_keys = {}
	
	for x = 0, 100 do --Will break once 100+ items in inventory, searches for valid security keys and adds them to list
		local item = search_inventory(x)
		if item:has_flag("TK_Izu_Security_Key") == true then
			security_keys[#security_keys + 1] = item
		end
	end

	for key = 1, #security_keys do -- Adds in UI entries for each key reutnred by above
		local security_key = security_keys[key]
		local security_key_name = security_key:display_name()
		menu_entry = ("Register "..security_key_name)
		register_security_key_menu:addentry(menu_entry)
	end
	
	register_security_key_menu:show()-- Draw up UI and await choice
	register_security_key_menu:query(true)
	local choice = register_security_key_menu.selected
	
	if choice == 0 then -- Takes choice and runs with it
		show_tk_izu_connection_menu()
	else
		local security_key = security_keys[choice] 
		if security_key:has_flag("Security_Key_Logistics") then -- Looks at item flags, multiple security keys can be obtained from a single item this way
			player:add_effect(efftype_id("Security_Key_Logistics"), TURNS(1), "bp_head", true)
			player:i_rem(security_key)
			game.add_msg("The computer gives a small beep, and the security registry program fries the USB drive")
			show_register_security_key_menu()
		end
		if security_key:has_flag("Security_Key_Field_Op") then
			player:add_effect(efftype_id("Security_Key_Field_Op"), TURNS(1), "bp_head", true)
			player:i_rem(security_key)
			game.add_msg("The computer gives a small beep, and the security registry program fries the USB drive")
			show_register_security_key_menu()
		end
	end

end

function show_commissary_selection_menu()
	
	create_commissary_selection_menu()
	
	for key = 1, #supply_lists_list do
		local supply_list_name = supply_lists_list[key][1]
		menu_entry = ("Access "..supply_list_name)
		commissary_selection_menu:addentry(menu_entry)
	end
	
	commissary_selection_menu:show()
	commissary_selection_menu:query(true)
	
	local choice = commissary_selection_menu.selected
	if choice == 0 then
		show_tk_izu_connection_menu()
	else
		supply_list = supply_lists_list[choice][0]
		show_supply_selection_menu()
	end

end

function show_supply_selection_menu()

	create_supply_selection_menu()
	
	for key = 1, #supply_list do
		local item = item(supply_list[key][1], supply_list[key][2])
		local price = math.floor(tonumber(supply_list[key][3]) / 100)
		local menu_entry = ("Purchase "..supply_list[key][2].." "..item:display_name().." for $"..price)
		supply_selection_menu:addentry(menu_entry)
	end
	
	supply_selection_menu:show()
	supply_selection_menu:query(true)
	
	local choice = supply_selection_menu.selected
	if choice == 0 
	and #current_purchases < 1 then
		show_commissary_selection_menu()
	elseif choice == 0
	and #current_purchases >= 1 then
		drop_pod_generation()
		game.add_msg( "Launching drop pod with current selection..." )
	else
		local purchase_container = supply_list[choice][0]
		local purchase_item_id = supply_list[choice][1]
		local purchase_quantity = supply_list[choice][2]
		local purchase_price = math.floor(tonumber(supply_list[choice][3]))
		local purchase_security_clearance = efftype_id(supply_list[choice][4])
		local money = player.cash
		if money >= purchase_price 
		and player:has_effect(purchase_security_clearance) == true then
			player.cash = money - purchase_price
			current_purchases[#current_purchases + 1] = { [0] = purchase_container, [1] = purchase_item_id, [2] = purchase_quantity }
			show_supply_selection_menu()
		elseif player:has_effect(purchase_security_clearance) == false then
			show_permission_denied_menu()
		else 
			show_insufficent_funds_menu()
		end
	end

end

function show_insufficent_funds_menu()

	create_insufficent_funds_menu()
	insufficent_funds_menu:show()
	insufficent_funds_menu:query(true)
	show_supply_selection_menu()
	
end

function show_drop_pod_in_transit_menu()

	create_drop_pod_in_transit_menu()
	drop_pod_in_transit_menu:show()
	drop_pod_in_transit_menu:query(true)
	show_tk_izu_connection_menu()
	
end

function show_permission_denied_menu()

	create_permission_denied_menu()
	permission_denied_menu:show()
	permission_denied_menu:query(true)
	show_supply_selection_menu()
	
end

-- Drop Pod Generation / Landing
-- Drop Pod Generation var format:
-- ( "x", item_id ) and ( "x * 1000", quantity )
-- These vars are extracted from the item to retrieve contents in the iuse_actions file

function drop_pod_generation()
	local drop_pod = item("BioCo_10L_Drop_Pod", 1)
	items_to_load = #current_purchases
	drop_pod:set_var("items_loaded", items_to_load)
	for x = 1, items_to_load do
		drop_pod:set_var((x.."container"), current_purchases[x][0])
		drop_pod:set_var((x.."name"), current_purchases[x][1])
		drop_pod:set_var((x.."quantity"), current_purchases[x][2])
	end
	drop_pod_landing(drop_pod)
	current_purchases = {}
end	

function drop_pod_landing(item)
	
	co_drop_pod_landing = coroutine.create(function(item)

		local drop_pod = item
		local center = player:pos()
	
		-- establishing list of possible landing spots
		local drop_pod_possible_drops = {}
		for off = 1, 11 do
			for x = -off, off do
				for y = -off, off do
				local z = 0 
					if math.abs(x) == off or math.abs(y) == off then
						local point = tripoint(center.x + x, center.y + y, center.z + z)
						local distance_to_player = math.sqrt( ((center.x - point.x)^2) + ((center.y - point.y)^2) )
						if distance_to_player >= 6 then
							drop_pod_possible_drops[#drop_pod_possible_drops + 1] = point
						end
					end
				end
			end
		end
		
		-- figure out where the pod is going to land from list
		local key = math.random(#drop_pod_possible_drops)
		local drop_pod_location = drop_pod_possible_drops[key]
		drop_pod_tta = math.random(10,25)
		
		-- launch pod, wait around for a bit
		drop_pod_in_transit = true
			coroutine.yield()
		for t = 1, drop_pod_tta do
			coroutine.yield()
		end
		
		-- annnnd pod landing
		g:explosion(drop_pod_location, 35)
		map:add_item(drop_pod_location, drop_pod)
		game.add_msg("<color_green>Drop Pod Touchdown Confirmed</color>")
		drop_pod_in_transit = false
	end )
	
	coroutine.resume(co_drop_pod_landing, item)

end 