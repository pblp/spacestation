/*
CONTAINS:
SPACE CLEANER
MOP

*/
/obj/item/weapon/cleaner/New()
	var/datum/reagents/R = new/datum/reagents(250)
	reagents = R
	R.my_atom = src
	R.add_reagent("cleaner", 250)

/obj/item/weapon/cleaner/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/weapon/cleaner/afterattack(atom/A as mob|obj, mob/user as mob)
	if (istype(A, /obj/item/weapon/storage ))
		return
	if (istype(A, /obj/effect/proc_holder/spell ))
		return
	else if (src.reagents.total_volume < 1)
		user << "\blue [src] is empty!"
		return

	var/obj/effect/decal/D = new/obj/effect/decal(get_turf(src))
	D.create_reagents(5)
	src.reagents.trans_to(D, 5)

	var/list/rgbcolor_hyalor = list(0,0,0)
	var/finalcolor_hyalor
	for(var/datum/reagent/re in D.reagents.reagent_list) // natural color_hyalor mixing bullshit/algorithm
		if(!finalcolor_hyalor)
			rgbcolor_hyalor = Getcolor_hyalors(re.color_hyalor)
			finalcolor_hyalor = re.color_hyalor
		else
			var/newcolor_hyalor[3]
			var/prergbcolor_hyalor[3]
			prergbcolor_hyalor = rgbcolor_hyalor
			newcolor_hyalor = Getcolor_hyalors(re.color_hyalor)

			rgbcolor_hyalor[1] = (prergbcolor_hyalor[1]+newcolor_hyalor[1])/2
			rgbcolor_hyalor[2] = (prergbcolor_hyalor[2]+newcolor_hyalor[2])/2
			rgbcolor_hyalor[3] = (prergbcolor_hyalor[3]+newcolor_hyalor[3])/2

			finalcolor_hyalor = rgb(rgbcolor_hyalor[1], rgbcolor_hyalor[2], rgbcolor_hyalor[3])
			// This isn't a perfect color_hyalor mixing system, the more reagents that are inside,
			// the darker it gets until it becomes absolutely pitch black! I dunno, maybe
			// that's pretty realistic? I don't do a whole lot of color_hyalor-mixing anyway.
			// If you add brighter color_hyalors to it it'll eventually get lighter, though.

	D.name = "chemicals"
	D.icon = 'chempuff.dmi'

	D.icon += finalcolor_hyalor

	playsound(src.loc, 'spray2.ogg', 50, 1, -6)

	spawn(0)
		for(var/i=0, i<3, i++)
			step_towards(D,A)
			D.reagents.reaction(get_turf(D))
			for(var/atom/T in get_turf(D))
				D.reagents.reaction(T)
			sleep(3)
		del(D)

	if(isrobot(user)) //Cyborgs can clean forever if they keep charged
		var/mob/living/silicon/robot/janitor = user
		janitor.cell.charge -= 20
		var/refill = src.reagents.get_master_reagent_id()
		spawn(600)
			src.reagents.add_reagent(refill, 10)


	if((src.reagents.has_reagent("pacid")) || (src.reagents.has_reagent("lube"))) 	   				// Messages admins if someone sprays polyacid or space lube from a Cleaner bottle.
		message_admins("[key_name_admin(user)] fired Polyacid/Space lube from a Cleaner bottle.")			// Polymorph
		log_game("[key_name(user)] fired Polyacid/Space lube from a Cleaner bottle.")



	return

/obj/item/weapon/cleaner/examine()
	set src in usr
	for(var/datum/reagent/R in reagents.reagent_list)
		usr << text("\icon[] [] units of [] left!", src, round(R.volume), R.name)
	//usr << text("\icon[] [] units of cleaner left!", src, src.reagents.total_volume)
	..()
	return

/obj/item/weapon/chemsprayer/New()
	var/datum/reagents/R = new/datum/reagents(1000)
	reagents = R
	R.my_atom = src
	R.add_reagent("cleaner", 10)

/obj/item/weapon/chemsprayer/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/weapon/chemsprayer/afterattack(atom/A as mob|obj, mob/user as mob)
	if (istype(A, /obj/item/weapon/storage ))
		return
	if (istype(A, /obj/effect/proc_holder/spell ))
		return
	else if (src.reagents.total_volume < 1)
		user << "\blue [src] is empty!"
		return

	playsound(src.loc, 'spray2.ogg', 50, 1, -6)

	var/Sprays[3]
	for(var/i=1, i<=3, i++) // intialize sprays
		if(src.reagents.total_volume < 1) break
		var/obj/effect/decal/D = new/obj/effect/decal(get_turf(src))
		D.name = "chemicals"
		D.icon = 'chempuff.dmi'
		D.create_reagents(5)
		src.reagents.trans_to(D, 5)

		var/rgbcolor_hyalor[3]
		var/finalcolor_hyalor
		for(var/datum/reagent/re in D.reagents.reagent_list)
			if(!finalcolor_hyalor)
				rgbcolor_hyalor = Getcolor_hyalors(re.color_hyalor)
				finalcolor_hyalor = re.color_hyalor
			else
				var/newcolor_hyalor[3]
				var/prergbcolor_hyalor[3]
				prergbcolor_hyalor = rgbcolor_hyalor
				newcolor_hyalor = Getcolor_hyalors(re.color_hyalor)

				rgbcolor_hyalor[1] = (prergbcolor_hyalor[1]+newcolor_hyalor[1])/2
				rgbcolor_hyalor[2] = (prergbcolor_hyalor[2]+newcolor_hyalor[2])/2
				rgbcolor_hyalor[3] = (prergbcolor_hyalor[3]+newcolor_hyalor[3])/2

				finalcolor_hyalor = rgb(rgbcolor_hyalor[1], rgbcolor_hyalor[2], rgbcolor_hyalor[3])

		D.icon += finalcolor_hyalor

		Sprays[i] = D

	var/direction = get_dir(src, A)
	var/turf/T = get_turf(A)
	var/turf/T1 = get_step(T,turn(direction, 90))
	var/turf/T2 = get_step(T,turn(direction, -90))
	var/list/the_targets = list(T,T1,T2)

	for(var/i=1, i<=Sprays.len, i++)
		spawn()
			var/obj/effect/decal/D = Sprays[i]
			if(!D) continue

			// Spreads the sprays a little bit
			var/turf/my_target = pick(the_targets)
			the_targets -= my_target

			for(var/j=1, j<=rand(6,8), j++)
				step_towards(D, my_target)
				D.reagents.reaction(get_turf(D))
				for(var/atom/t in get_turf(D))
					D.reagents.reaction(t)
				sleep(2)
			del(D)
	sleep(1)

	if(isrobot(user)) //Cyborgs can clean forever if they keep charged
		var/mob/living/silicon/robot/janitor = user
		janitor.cell.charge -= 20
		var/refill = src.reagents.get_master_reagent_id()
		spawn(600)
			src.reagents.add_reagent(refill, 10)


	if((src.reagents.has_reagent("pacid")) || (src.reagents.has_reagent("lube")))  				// Messages admins if someone sprays polyacid or space lube from a Chem Sprayer.
		message_admins("[key_name_admin(user)] fired Polyacid/Space lube from a Chem Sprayer.")			// Polymorph
		log_game("[key_name(user)] fired Polyacid/Space lube from a Chem Sprayer.")


	return

/obj/item/weapon/pepperspray/New()
	var/datum/reagents/R = new/datum/reagents(45)
	reagents = R
	R.my_atom = src
	R.add_reagent("condensedcapsaicin", 45)

/obj/item/weapon/pepperspray/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/weapon/pepperspray/afterattack(atom/A as mob|obj, mob/user as mob)
	if (istype(A, /obj/item/weapon/storage ))
		return
	if (istype(A, /obj/effect/proc_holder/spell ))
		return
	else if (istype(A, /obj/structure/reagent_dispensers/peppertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 45)
		user << "\blue Pepper spray refilled"
		playsound(src.loc, 'refill.ogg', 50, 1, -6)
		return
	else if (src.reagents.total_volume < 1)
		user << "\blue [src] is empty!"
		return
	playsound(src.loc, 'spray2.ogg', 50, 1, -6)

	var/Sprays[3]
	for(var/i=1, i<=3, i++) // intialize sprays
		if(src.reagents.total_volume < 1) break
		var/obj/effect/decal/D = new/obj/effect/decal(get_turf(src))
		D.name = "chemicals"
		D.icon = 'chempuff.dmi'
		D.create_reagents(15)
		src.reagents.trans_to(D, 15)

		var/rgbcolor_hyalor[3]
		var/finalcolor_hyalor
		for(var/datum/reagent/re in D.reagents.reagent_list)
			if(!finalcolor_hyalor)
				rgbcolor_hyalor = Getcolor_hyalors(re.color_hyalor)
				finalcolor_hyalor = re.color_hyalor
			else
				var/newcolor_hyalor[3]
				var/prergbcolor_hyalor[3]
				prergbcolor_hyalor = rgbcolor_hyalor
				newcolor_hyalor = Getcolor_hyalors(re.color_hyalor)

				rgbcolor_hyalor[1] = (prergbcolor_hyalor[1]+newcolor_hyalor[1])/2
				rgbcolor_hyalor[2] = (prergbcolor_hyalor[2]+newcolor_hyalor[2])/2
				rgbcolor_hyalor[3] = (prergbcolor_hyalor[3]+newcolor_hyalor[3])/2

				finalcolor_hyalor = rgb(rgbcolor_hyalor[1], rgbcolor_hyalor[2], rgbcolor_hyalor[3])

		D.icon += finalcolor_hyalor

		Sprays[i] = D

	var/direction = get_dir(src, A)
	var/turf/T = get_turf(A)
	var/turf/T1 = get_step(T,turn(direction, 90))
	var/turf/T2 = get_step(T,turn(direction, -90))
	var/list/the_targets = list(T,T1,T2)

	for(var/i=1, i<=Sprays.len, i++)
		spawn()
			var/obj/effect/decal/D = Sprays[i]
			if(!D) continue

			// Spreads the sprays a little bit
			var/turf/my_target = pick(the_targets)
			the_targets -= my_target

			for(var/j=1, j<=rand(6,8), j++)
				step_towards(D, my_target)
				D.reagents.reaction(get_turf(D))
				for(var/atom/t in get_turf(D))
					D.reagents.reaction(t)
				sleep(2)
			del(D)
	sleep(1)

	if(isrobot(user)) //Cyborgs can clean forever if they keep charged
		var/mob/living/silicon/robot/janitor = user
		janitor.cell.charge -= 20
		var/refill = src.reagents.get_master_reagent_id()
		spawn(600)
			src.reagents.add_reagent(refill, 10)

	return

/obj/item/weapon/pepperspray/examine()
	set src in usr
	usr << text("\icon[] [] units of spray left!", src, src.reagents.total_volume)
	..()
	return

// MOP

/obj/item/weapon/mop/New()
	var/datum/reagents/R = new/datum/reagents(5)
	reagents = R
	R.my_atom = src

obj/item/weapon/mop/proc/clean(turf/simulated/A as turf)
	src.reagents.reaction(A,1,10)
	A.clean_blood()
	for(var/obj/effect/rune/R in A)
		del(R)
	for(var/obj/effect/decal/cleanable/R in A)
		del(R)
	for(var/obj/effect/overlay/R in A)
		del(R)

/obj/effect/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/mop))
		return
	..()

/obj/item/weapon/mop/afterattack(atom/A, mob/user as mob)
	if (src.reagents.total_volume < 1 || mopcount >= 5)
		user << "\blue Your mop is dry!"
		return

	if (istype(A, /turf/simulated))
		for(var/mob/O in viewers(user, null))
			O.show_message("\red <B>[user] begins to clean \the [A]</B>", 1)
		sleep(40)
		clean(A)
		user << "\blue You have finished mopping!"
		mopcount++
	else if (istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay) || istype(A, /obj/effect/rune))
		for(var/mob/O in viewers(user, null))
			O.show_message("\red <B>[user] begins to clean \the [get_turf(A)]</B>", 1)
		sleep(40)
		clean(get_turf(A))
		user << "\blue You have finished mopping!"
		mopcount++

	if(mopcount >= 5) //Okay this stuff is an ugly hack and i feel bad about it.
		spawn(5)
			src.reagents.clear_reagents()
			mopcount = 0

	return



/*
 *  Hope it's okay to stick this shit here: it basically just turns a hexadecimal color_hyalor into rgb
 */

proc/Getcolor_hyalors(hex)
    hex = uppertext(hex)
    var
        hi1 = text2ascii(hex, 2)
        lo1 = text2ascii(hex, 3)
        hi2 = text2ascii(hex, 4)
        lo2 = text2ascii(hex, 5)
        hi3 = text2ascii(hex, 6)
        lo3 = text2ascii(hex, 7)
    return list(((hi1>= 65 ? hi1-55 : hi1-48)<<4) | (lo1 >= 65 ? lo1-55 : lo1-48),
        ((hi2 >= 65 ? hi2-55 : hi2-48)<<4) | (lo2 >= 65 ? lo2-55 : lo2-48),
        ((hi3 >= 65 ? hi3-55 : hi3-48)<<4) | (lo3 >= 65 ? lo3-55 : lo3-48))









