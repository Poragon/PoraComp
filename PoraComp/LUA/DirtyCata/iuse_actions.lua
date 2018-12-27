-- Variables

soap_list = {}

-- Coroutines

-- Functions

function wishy_wash(tool)
	if tool:has_flag("BAD_WASH") == true then
		for x = 1, 100 do
			local item = search_inventory(x)
			if item:has_flag("SAFE_SOAP") then
				soap_list[#soap_list + 1] = item
			end
			if item == "clean_water" then
			end --Left off point
		end
	elseif tool:has_flag("WASH") == true then
	elseif tool:has_flag("GOOD_WASH")== true then
	end
end