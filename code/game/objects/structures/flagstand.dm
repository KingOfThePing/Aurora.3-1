
/obj/structure/flagstand
    name = "blank flagstand"
    desc = "A wooden structure for holding flags. This one has a blank flag attached."
    icon = 'icons/obj/tajara_items.dmi'
    icon_state = "blank_banner"
    anchored = TRUE
    density = FALSE
    var/folded = FALSE

/obj/structure/flagstand/attack_hand(mob/user)
    fold(user)
    add_fingerprint(user)

/obj/structure/flagstand/proc/fold(var/mob/living/user)
    if(!folded)
        icon_state = "[initial(icon_state)]_up"
        user.visible_message(SPAN_NOTICE("\The [user] folds \the [src]."))
    else
        icon_state = initial(icon_state)
        user.visible_message(SPAN_NOTICE("\The [user] unfolds \the [src]."))
    playsound(get_turf(loc), /singleton/sound_category/rustle_sound, 15, 1, -5)
