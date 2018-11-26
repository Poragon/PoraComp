zygote_growth_count = coroutine.create(function ()
	for d=1,5 do
		coroutine.yield()
	end
	game.add_msg("<color_magenta>Where... are we?</color>")
	player:remove_effect(efftype_id("PA_037_Zygote"))
	player:add_effect(efftype_id("Fledgling_037"), DAYS(10000))
end)