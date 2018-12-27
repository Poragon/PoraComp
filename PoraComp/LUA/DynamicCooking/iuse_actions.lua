-- Variables

-- Coroutines

-- Functions

function dynamic_food_iuse(item)

	local nutrition = tonumber(item:get_var("nutrition", 0))
	local current_hunger = player:get_hunger()
	local hunger_mod = nutrition * -1
	if current_hunger + hunger_mod >= -20 then
		player:mod_stomach_food(nutrition)
		player:mod_hunger(nutrition * -1)
		game.add_msg("<color_green>Mmmm... a hearty meal!</color>")
		player:i_rem(item)
	else
		game.add_msg("<color_red>You're so stuff, you couldn't eat another bite!</color>")
	end
	
end

-- Game Registers

game.register_iuse("Dynamic_Food", dynamic_food_iuse)