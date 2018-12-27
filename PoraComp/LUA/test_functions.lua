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