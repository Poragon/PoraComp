-- Variables

-- Coroutines

zygote_growth_count = coroutine.create(function ()
	for d=1,5 do
		coroutine.yield()
	end
	game.add_msg("<color_magenta>Where... are we?</color>")
	player:remove_effect(efftype_id("PA_037_Zygote"))
	player:add_effect(efftype_id("Fledgling_037"), DAYS(10000))
end )

-- Functions

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