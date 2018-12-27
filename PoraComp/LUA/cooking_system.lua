possible_liquid_ingredients = {}
possible_solid_ingredients = {}
dish_ingredients = {}
dish_state = 0
dish_nutrition = 0
dish_volume = 0

function find_possible_ingredients() -- Creates a two lists of valid liquid and solid ingredients from inventory
	for x = 0, 1000 do
		local inv_entry = player:i_at(x)
		if inv_entry:is_food() == true 
		and inv_entry:made_of("LIQUID") == true then
			-- Ingredient list format:
			-- possible_ingredients[x] = item&
			possible_liquid_ingredients[#possible_liquid_ingredients + 1] = inv_entry
		elseif inv_entry:is_food() == true
		and inv_entry:made_of("LIQUID") == false then
			possible_solid_ingredients[#possible_solid_ingredients + 1] = inv_entry
		end
	end
end

function create_cooking_menu() -- Creates the cooking menu which has the selection for what cooking tools the player has

	cooking_menu = game.create_uimenu()
    cooking_menu.title = "Select an Ingredient"
	if #dish_ingredients == 0 then
		cooking_menu:addentry( "Cancel Cooking" )
	else
		cooking_menu:addentry( "Begin Cooking" )
	end
	
end

function show_cooking_menu() -- Fills out framework created by create_cooking_menu() with list entries from find_possible_ingredients()
	
	create_cooking_menu() -- Creates UI, clears pre existing list entries
	possible_liquid_ingredients = {}
	possible_solid_ingredients = {}
	find_possible_ingredients()
	
	if #possible_solid_ingredients >= 1 then -- Adds possible_solid_ingredients to menu selection
		for key = 1, #possible_solid_ingredients do
			local item = possible_solid_ingredients[key]
			local menu_entry = ("Add "..item:display_name())
			cooking_menu:addentry( menu_entry )
		end
	end
	if #possible_liquid_ingredients >= 1 then -- Adds possible_liquid_ingredients to menu selection
		for key = 1, #possible_liquid_ingredients do
			local item = possible_liquid_ingredients[key]
			local menu_entry = ("Add "..item:display_name())
			cooking_menu:addentry( menu_entry )
		end
	end
	
	cooking_menu:show()
	cooking_menu:query(true)
	local choice = cooking_menu.selected
	
	if choice == 0 
	and #dish_ingredients < 1 then
		return
	elseif choice == 0
	and #dish_ingredients >= 1 then
		
		dish_nutrition = 0 -- Reset previously written dish info
		dish_volume = 0
		
		for key = 1, #dish_ingredients do -- Set new dish info
			local ingredient = dish_ingredients[key]
			dish_nutrition = dish_nutrition + player:nutrition_for(ingredient) -- Code still uses tricky nutrition units. 8.6 kcal per nutrition unit is the conversion-ish
			dish_uses = dish_uses + 1
		end
		local dish = item("Dynamic_Food", 0, dish_uses)
		dish:set_var("nutrition", dish_nutrition)
		player:i_add(dish)
		dish_ingredients = {}
	elseif choice <= #possible_solid_ingredients then
		dish_state = dish_state + 1
		dish_ingredients[#dish_ingredients + 1] = possible_solid_ingredients[choice]
		show_cooking_menu()
	elseif choice > #possible_solid_ingredients
	and choice <= #possible_liquid_ingredients then
		dish_state = dish_state - 1
		dish_ingredients[#dish_ingredients + 1] = possible_liquid_ingredients[choice]
		show_cooking_menu()
	end
	

end