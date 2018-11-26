function Zygote_Kit_IV_iuse()
	if player:has_effect(efftype_id("Fledgling_037")) == false
	and player:has_effect(efftype_id("PA_037_Zygote")) == false then
		local dur = DAYS(10000)
		player:add_effect(efftype_id("PA_037_Zygote"), dur)
	end
end

game.register_iuse("Zygote_Kit_IV", Zygote_Kit_IV_iuse)