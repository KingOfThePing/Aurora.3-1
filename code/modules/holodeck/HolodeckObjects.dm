// Holographic Items!

// Holographic tables are in code/modules/tables/presets.dm
// Holographic racks are in code/modules/tables/rack.dm

/turf/simulated/floor/holofloor
	thermal_conductivity = 0

/turf/simulated/floor/holofloor/attackby(obj/item/attacking_item, mob/user)
	return
	// HOLOFLOOR DOES NOT GIVE A FUCK

/turf/simulated/floor/holofloor/set_flooring()
	return

/turf/simulated/floor/holofloor/carpet
	name = "carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "carpet"
	initial_flooring = /singleton/flooring/carpet
	footstep_sound = /singleton/sound_category/carpet_footstep

/turf/simulated/floor/holofloor/carpet/rubber
	name = "rubber carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "rub_carpet"
	initial_flooring = /singleton/flooring/carpet/rubber

/turf/simulated/floor/holofloor/tiled
	name = "floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "tiled_preview"
	initial_flooring = /singleton/flooring/tiling

/turf/simulated/floor/holofloor/tiled/ramp
	name = "foot ramp"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "ramptop"
	initial_flooring = /singleton/flooring/reinforced/ramp

/turf/simulated/floor/holofloor/tiled/ramp/bottom
	name = "foot ramp"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "rampbot"
	initial_flooring = /singleton/flooring/reinforced/ramp/bottom

/turf/simulated/floor/holofloor/tiled/dark
	name = "dark floor"
	icon_state = "dark_preview"
	initial_flooring = /singleton/flooring/tiling/dark

/turf/simulated/floor/holofloor/lino
	name = "lino"
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_state = "lino_diamond"
	initial_flooring = /singleton/flooring/linoleum/diamond
	color = COLOR_LINOLEUM

/turf/simulated/floor/holofloor/wood
	name = "wooden floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "wood"
	initial_flooring = /singleton/flooring/wood
	tile_outline = "wood"
	tile_outline_blend_process = ICON_ADD
	color = WOOD_COLOR_GENERIC

/turf/simulated/floor/holofloor/grass
	name = "lush grass"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_state = "grass0"
	initial_flooring = /singleton/flooring/grass

/turf/simulated/floor/holofloor/snow
	name = "snow"
	base_name = "snow"
	icon = 'icons/turf/flooring/snow.dmi'
	icon_state = "snow0"
	initial_flooring = /singleton/flooring/snow

/turf/simulated/floor/holofloor/reinforced
	icon = 'icons/turf/flooring/tiles.dmi'
	initial_flooring = /singleton/flooring/reinforced
	name = "reinforced holofloor"
	icon_state = "reinforced"
	footstep_sound = /singleton/sound_category/tiles_footstep

/turf/simulated/floor/holofloor/space
	icon = 'icons/turf/space.dmi'
	name = "\proper space"
	icon_state = "0"
	footstep_sound = null
	plane = SPACE_PLANE
	dynamic_lighting = 0

/turf/simulated/floor/holofloor/space/Initialize()
	. = ..()
	icon_state = "[((x + y) ^ ~(x * y) + z) % 25]"
	var/image/I = image('icons/turf/space_parallax1.dmi',"[icon_state]")
	I.plane = DUST_PLANE
	I.alpha = 80
	I.blend_mode = BLEND_ADD
	AddOverlays(I)

/turf/simulated/floor/holofloor/beach
	desc = "Uncomfortably gritty for a hologram."
	base_desc = "Uncomfortably gritty for a hologram."
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	base_icon = 'icons/misc/beach.dmi'
	initial_flooring = null
	footstep_sound = /singleton/sound_category/sand_footstep

/turf/simulated/floor/holofloor/beach/sand
	name = "sand"

/turf/simulated/floor/holofloor/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"
	base_icon_state = "sandwater"
	footstep_sound = /singleton/sound_category/water_footstep

/turf/simulated/floor/holofloor/beach/water
	name = "water"
	icon_state = "seashallow"
	base_icon_state = "seashallow"
	footstep_sound = /singleton/sound_category/water_footstep

/turf/simulated/floor/holofloor/desert
	name = "desert sand"
	base_name = "desert sand"
	desc = "Uncomfortably gritty for a hologram."
	base_desc = "Uncomfortably gritty for a hologram."
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	icon = 'icons/turf/flooring/asteroid.dmi'
	base_icon = 'icons/turf/flooring/asteroid.dmi'
	initial_flooring = null
	footstep_sound = /singleton/sound_category/sand_footstep

/turf/simulated/floor/holofloor/desert/Initialize()
	. = ..()
	if(prob(10))
		AddOverlays("asteroid[rand(0,9)]")

/obj/structure/holostool
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "stool_padded_preview"
	anchored = 1.0

/obj/item/clothing/gloves/boxing/hologlove
	name = "boxing gloves"
	desc = "Because you really needed another excuse to punch your crewmates."
	icon_state = "boxing"
	item_state = "boxing"

/obj/structure/window/reinforced/holowindow/Destroy()
	return ..()

/obj/structure/window/reinforced/holowindow/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item))
		return//I really wish I did not need this

	if (istype(attacking_item, /obj/item/grab) && get_dist(src,user)<2)
		var/obj/item/grab/G = attacking_item
		if(istype(G.affecting,/mob/living))
			grab_smash_attack(G, DAMAGE_PAIN)
			return

	if(attacking_item.item_flags & ITEM_FLAG_NO_BLUDGEON) return

	if(attacking_item.isscrewdriver())
		to_chat(user, (SPAN_NOTICE("It's a holowindow, you can't unfasten it!")))
	else if(attacking_item.iscrowbar() && reinf && state <= 1)
		to_chat(user, (SPAN_NOTICE("It's a holowindow, you can't pry it!")))
	else if(attacking_item.iswrench() && !anchored && (!state || !reinf))
		to_chat(user, (SPAN_NOTICE("It's a holowindow, you can't dismantle it!")))
	else
		if(attacking_item.damtype == DAMAGE_BRUTE || attacking_item.damtype == DAMAGE_BURN)
			hit(attacking_item.force)
			if(health <= 7)
				anchored = 0
				update_nearby_icons()
				step(src, get_dir(user, src))
		else
			playsound(loc, 'sound/effects/glass_hit.ogg', 75, 1)
		..()
	return

/obj/structure/window/reinforced/holowindow/shatter(var/display_message = 1)
	playsound(src, /singleton/sound_category/glass_break_sound, 70, 1)
	if(display_message)
		visible_message("[src] fades away as it shatters!")
	qdel(src)
	return

/obj/structure/window/reinforced/holowindow/disappearing/Destroy()
	return ..()

/obj/machinery/door/window/holowindoor/Destroy()
	return ..()

/obj/machinery/door/window/holowindoor/attackby(obj/item/attacking_item, mob/user)

	if (src.operating == 1)
		return

	if(src.density && istype(attacking_item, /obj/item) && !istype(attacking_item, /obj/item/card))
		var/aforce = attacking_item.force
		playsound(src.loc, 'sound/effects/glass_hit.ogg', 75, 1)
		visible_message(SPAN_DANGER("[src] was hit by [attacking_item]."))
		if(attacking_item.damtype == DAMAGE_BRUTE || attacking_item.damtype == DAMAGE_BURN)
			take_damage(aforce)
		return

	src.add_fingerprint(user)
	if (!src.requiresID())
		user = null

	if (src.allowed(user))
		if (src.density)
			open()
		else
			close()

	else if (src.density)
		flick("[src.base_state]deny", src)

	return

/obj/machinery/door/window/holowindoor/shatter(var/display_message = 1)
	src.density = 0
	playsound(src, /singleton/sound_category/glass_break_sound, 70, 1)
	if(display_message)
		visible_message("[src] fades away as it shatters!")
	qdel(src)

/obj/structure/bed/stool/chair/holochair
	held_item = null

/obj/structure/bed/stool/chair/holochair/Destroy()
	return ..()

/obj/structure/bed/stool/chair/holochair/attackby(obj/item/attacking_item, mob/user)
	if(attacking_item.iswrench())
		to_chat(user, (SPAN_NOTICE("It's a holochair, you can't dismantle it!")))
	return

/obj/item/holo
	damtype = DAMAGE_PAIN
	no_attack_log = 1

/obj/item/holo/esword
	name = "energy sword"
	desc = "May the force be within you. Sorta."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "sword0"
	force = 3
	throw_speed = 1
	throw_range = 5
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	atom_flags = ATOM_FLAG_NO_BLOOD
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/weapons/lefthand_energy.dmi',
		slot_r_hand_str = 'icons/mob/items/weapons/righthand_energy.dmi'
		)
	var/active = 0
	var/item_color

/obj/item/holo/esword/green
	item_color = "green"

/obj/item/holo/esword/red
	item_color = "red"

/obj/item/holo/esword/handle_shield(mob/user, var/on_back, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(active && default_parry_check(user, attacker, damage_source) && prob(50))
		user.visible_message(SPAN_DANGER("\The [user] parries [attack_text] with \the [src]!"))

		spark(user.loc, 5)
		playsound(user.loc, 'sound/weapons/blade.ogg', 50, 1)
		return BULLET_ACT_BLOCK
	return BULLET_ACT_HIT

/obj/item/holo/esword/New()
	if(!item_color)
		item_color = pick("red","blue","green","purple")

/obj/item/holo/esword/attack_self(mob/living/user as mob)
	active = !active
	if (active)
		force = 33
		icon_state = "sword[item_color]"
		w_class = WEIGHT_CLASS_BULKY
		playsound(user, 'sound/weapons/saberon.ogg', 50, 1)
		to_chat(user, SPAN_NOTICE("[src] is now active."))
	else
		force = 3
		icon_state = "sword0"
		w_class = WEIGHT_CLASS_SMALL
		playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
		to_chat(user, SPAN_NOTICE("[src] can now be concealed."))

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand()
		H.update_inv_r_hand()

	add_fingerprint(user)
	return
// ASCC holodeck practice sword

/obj/item/holo/practicesword
	name = "practice sword"
	desc = "A holographic fascimile of a sword, except this one has no sharp points or edges that might cause injury."
	icon = 'icons/obj/sword.dmi'
	icon_state = "longsword"
	item_state = "longsword"
	contained_sprite = TRUE
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	atom_flags = ATOM_FLAG_NO_BLOOD
	force = 1
	throw_speed = 1
	throw_range = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	can_embed = 0
	drop_sound = 'sound/items/drop/sword.ogg'
	pickup_sound = /singleton/sound_category/sword_pickup_sound
	equip_sound = /singleton/sound_category/sword_equip_sound

/obj/item/holo/practicesword/holorapier
	name = "fencing rapier"
	desc = "A light sword with a cupped hilt which protects the hand, and a very thin blade that ends in a fine point. This one is but a hologram, unable to inflict actual wounds. Hopefully."
	icon = 'icons/obj/sword.dmi'
	icon_state = "rapier"
	item_state = "rapier"
	slot_flags = SLOT_BELT

/obj/item/holo/practicesword/handle_shield(mob/user, var/on_back, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(default_parry_check(user, attacker, damage_source) && prob(50))
		user.visible_message(SPAN_DANGER("\The [user] parries [attack_text] with \the [src]!"))
		playsound(user.loc, 'sound/weapons/bladeparry.ogg', 50, 1)
		return BULLET_ACT_BLOCK
	return BULLET_ACT_HIT


// end

//BASKETBALL OBJECTS

/obj/item/beach_ball/holoball
	icon = 'icons/obj/basketball.dmi'
	icon_state = "basketball"
	name = "basketball"
	item_state = "basketball"
	desc = "Here's your chance, do your dance at the Space Jam."
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets
	drop_sound = 'sound/items/drop/basketball.ogg'
	pickup_sound = 'sound/items/pickup/basketball.ogg'

/obj/structure/holohoop
	name = "basketball hoop"
	desc = "Boom, Shakalaka!"
	icon = 'icons/obj/basketball.dmi'
	icon_state = "hoop"
	anchored = TRUE
	density = TRUE
	pass_flags_self = PASSSTRUCTURE | LETPASSTHROW

/obj/structure/holohoop/attackby(obj/item/attacking_item, mob/user)
	if (istype(attacking_item, /obj/item/grab) && get_dist(src,user)<2)
		var/obj/item/grab/G = attacking_item
		if(G.state<2)
			to_chat(user, SPAN_WARNING("You need a better grip to do that!"))
			return
		G.affecting.forceMove(src.loc)
		G.affecting.Weaken(5)
		visible_message(SPAN_WARNING("[G.assailant] dunks [G.affecting] into the [src]!"), range = 3)
		qdel(attacking_item)
		return
	else if (istype(attacking_item, /obj/item) && get_dist(src,user)<2)
		user.drop_from_inventory(attacking_item, get_turf(src))
		visible_message(SPAN_NOTICE("[user] dunks [attacking_item] into the [src]!"), range = 3)
		return

/obj/structure/holohoop/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/projectile))
			return
		if(prob(50))
			I.forceMove(src.loc)
			visible_message(SPAN_NOTICE("Swish! \the [I] lands in \the [src]."), range = 3)
		else
			visible_message(SPAN_WARNING("\The [I] bounces off of \the [src]'s rim!"), range = 3)
		return 0
	else
		return ..()


/obj/machinery/readybutton
	name = "Ready Declaration Device"
	desc = "This device is used to declare ready. If all devices in an area are ready, the event will begin!"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "auth_off"
	var/ready = 0
	var/area/currentarea = null
	var/eventstarted = 0

	anchored = 1.0
	use_power = POWER_USE_OFF // reason is because the holodeck already takes power so this can be powered as a result.

/obj/machinery/readybutton/attack_ai(mob/user as mob)
	to_chat(user, "The AI is not to interact with these devices!")
	return

/obj/machinery/readybutton/attackby(obj/item/attacking_item, mob/user)
	to_chat(user, "The device is a solid button, there's nothing you can do with it!")

/obj/machinery/readybutton/attack_hand(mob/user as mob)

	if(user.stat || stat & (NOPOWER|BROKEN))
		to_chat(user, "This device is not powered.")
		return

	if(!user.IsAdvancedToolUser())
		return 0

	currentarea = get_area(src.loc)
	if(!currentarea)
		qdel(src)

	if(eventstarted)
		to_chat(usr, "The event has already begun!")
		return

	ready = !ready

	update_icon()

	var/numbuttons = 0
	var/numready = 0
	for(var/obj/machinery/readybutton/button in currentarea)
		numbuttons++
		if (button.ready)
			numready++

	if(numbuttons == numready)
		begin_event()

/obj/machinery/readybutton/update_icon()
	if(ready)
		icon_state = "auth_on"
	else
		icon_state = "auth_off"

/obj/machinery/readybutton/proc/begin_event()

	eventstarted = 1

	for(var/obj/structure/window/reinforced/holowindow/disappearing/W in currentarea)
		qdel(W)

	for(var/mob/M in currentarea)
		to_chat(M, "FIGHT!")

//Holocarp

/mob/living/simple_animal/hostile/carp/holodeck
	icon = 'icons/mob/AI.dmi'
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp"
	alpha = 127
	icon_gib = null
	meat_amount = 0
	meat_type = null
	light_range = 2
	smart_melee = TRUE

/mob/living/simple_animal/hostile/carp/holodeck/proc/set_safety(var/safe)
	if (safe)
		faction = "neutral"
		melee_damage_lower = 0
		melee_damage_upper = 0
		environment_smash = 0
		destroy_surroundings = 0
	else
		faction = "carp"
		melee_damage_lower = initial(melee_damage_lower)
		melee_damage_upper = initial(melee_damage_upper)
		environment_smash = initial(environment_smash)
		destroy_surroundings = initial(destroy_surroundings)

/mob/living/simple_animal/hostile/carp/holodeck/gib()
	derez() //holograms can't gib

/mob/living/simple_animal/hostile/carp/holodeck/death()
	..()
	derez()

/mob/living/simple_animal/hostile/carp/holodeck/pain
	damage_type = DAMAGE_PAIN

/mob/living/simple_animal/hostile/carp/holodeck/pain/Initialize()
	. = ..()
	set_safety(FALSE)

/mob/living/simple_animal/hostile/carp/holodeck/pain/set_safety(safe)
	faction = "carp"
	melee_damage_lower = 5
	melee_damage_upper = 5
	environment_smash = 0
	destroy_surroundings = FALSE

//Holo-penguin

/mob/living/simple_animal/penguin/holodeck
	icon = 'icons/mob/npc/penguins.dmi'
	icon_state = "penguin"
	icon_living = "penguin"
	icon_dead = "penguin_dead"
	icon_gib = null
	meat_amount = 0
	meat_type = null
	light_range = 2
	hunger_enabled = FALSE

/mob/living/simple_animal/penguin/holodeck/can_name(var/mob/living/M)
	return FALSE

/mob/living/simple_animal/penguin/holodeck/baby
	name = "baby penguin"
	desc = "Can't fly and barely waddles, yet the prince of all chicks."
	icon_state = "penguin_baby"
	icon_living = "penguin_baby"
	icon_dead = "penguin_baby_dead"

/mob/living/simple_animal/penguin/holodeck/emperor
	name = "emperor penguin"
	desc = "Emperor of all he surveys."

/mob/living/simple_animal/penguin/holodeck/gib()
	derez() //holograms can't gib

/mob/living/simple_animal/penguin/holodeck/death()
	..()
	derez()

//Holo Animal babies

/mob/living/simple_animal/corgi/puppy/holodeck
	icon_gib = null
	meat_amount = 0
	meat_type = null
	light_range = 2
	hunger_enabled = FALSE

/mob/living/simple_animal/corgi/puppy/holodeck/can_name(var/mob/living/M)
	return FALSE

/mob/living/simple_animal/corgi/puppy/holodeck/gib()
	derez() //holograms can't gib

/mob/living/simple_animal/corgi/puppy/holodeck/death()
	..()
	derez()

/mob/living/simple_animal/cat/kitten/holodeck
	icon_gib = null
	meat_amount = 0
	meat_type = null
	light_range = 2
	hunger_enabled = FALSE

/mob/living/simple_animal/cat/kitten/holodeck/can_name(var/mob/living/M)
	return FALSE

/mob/living/simple_animal/cat/kitten/holodeck/gib()
	derez() //holograms can't gib

/mob/living/simple_animal/cat/kitten/holodeck/death()
	..()
	derez()
