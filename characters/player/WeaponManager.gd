extends Spatial

enum WEAPON_SLOTS {MACHETE, MACHINE_GUN, SHOTGUN, ROCKET_LAUNCHER}
var slots_unlocked = {
	WEAPON_SLOTS.MACHETE: true,
	WEAPON_SLOTS.MACHINE_GUN: true,
	WEAPON_SLOTS.SHOTGUN: true,
	WEAPON_SLOTS.ROCKET_LAUNCHER: true
}

onready var weapons = $Weapons.get_children()
var cur_slot = 0
var cur_weapon = null

func _ready():
	pass
	
func switch_to_next_weapon():
	# Works since 0%4=0 1%4=1, 2%4=2, 3%4=3
	cur_slot = (cur_slot + 1) % slots_unlocked.size()
	if !slots_unlocked[cur_slot]:
		switch_to_next_weapon()
	else:
		switch_to_weapon_slot(cur_slot)
	
func switch_to_last_weapon():
	# Same as above, but godot makes -3 % 4 = -3, so we need posmod to
	# make it a positive result since we're indexing
	cur_slot = posmod((cur_slot - 1), slots_unlocked.size())
	if !slots_unlocked[cur_slot]:
		switch_to_last_weapon()
	else:
		switch_to_weapon_slot(cur_slot)
	
func switch_to_weapon_slot(slot_ind):
	if slot_ind < 0 or slot_ind >= slots_unlocked.size():
		return
	if !slots_unlocked[cur_slot]:
		return
	disable_all_weapons()
	cur_weapon = weapons[slot_ind]
	if cur_weapon.has_method("set_active"):
		cur_weapon.set_active()
	else:
		cur_weapon.show()

func disable_all_weapons():
	for weapon in weapons:
		if weapon.has_method("set_inactive"):
			weapon.set_inactive()
		else:
			weapon.hide()
