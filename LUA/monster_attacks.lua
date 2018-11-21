function beserk_charge_attack(monster)
	local mon = game.get_critter_at(monster:pos())
	local beserker_rage = efftype_id("beserker_rage")
	local beserker_rage_duration = TURNS(7)
	if monster:sees(player) == true then
		game.add_msg("The "..monster:get_name().." lets out a blood curling roar!")
		monster:add_effect(beserker_rage, beserker_rage_duration)
	else
		return false;
	end
end

function update_attack(monster)
	monster_update()
	return true
end

game.register_monattack("BESERK_CHARGE", beserk_charge_attack)
game.register_monattack("UPDATE", update_attack)