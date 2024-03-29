/mob/living/carbon/human/attack_hand(mob/living/carbon/human/M as mob)
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

	..()

	if((M != src) && check_shields(0, M.name))
		visible_message("\red <B>[M] attempted to touch [src]!</B>")
		return 0

	if(M.gloves)
		if(M.gloves.cell)
			if(M.a_intent == "hurt")
				if(M.gloves.cell.charge >= 2500)
					M.gloves.cell.charge -= 2500
					visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
					M.attack_log += text("\[[time_stamp()]\] <font color='red'>Stungloved [src.name] ([src.ckey])</font>")
					src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stungloved by [M.name] ([M.ckey])</font>")


					log_attack("<font color='red'>[M.name] ([M.ckey]) stungloved [src.name] ([src.ckey])</font>")


					var/armorblock = run_armor_check(M.zone_sel.selecting, "energy")
					apply_effects(5,5,0,0,5,0,0,armorblock)
					return 1
				else
					M << "\red Not enough charge! "
					visible_message("\red <B>[src] has been touched with the stun gloves by [M]!</B>")
				return

	switch(M.a_intent)
		if("help")
			if(health > 0)
				help_shake_act(M)
				return 1
			if(M.health < -75)	return 0

			if((M.head && (M.head.flags & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags & MASKCOVERSMOUTH)))
				M << "\blue <B>Remove your mask!</B>"
				return 0
			if((head && (head.flags & HEADCOVERSMOUTH)) || (wear_mask && (wear_mask.flags & MASKCOVERSMOUTH)))
				M << "\blue <B>Remove his mask!</B>"
				return 0

			var/obj/effect/equip_e/human/O = new /obj/effect/equip_e/human()
			O.source = M
			O.target = src
			O.s_loc = M.loc
			O.t_loc = loc
			O.place = "CPR"
			requests += O
			spawn(0)
				O.process()
			return 1

		if("grab")
			if(M == src)	return 0
			if(w_uniform)	w_uniform.add_fingerprint(M)
			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M)
			G.assailant = M
			if (M.hand)
				M.l_hand = G
			else
				M.r_hand = G
			G.layer = 20
			G.affecting = src
			grabbed_by += G
			G.synch()
			LAssailant = M

			playsound(loc, 'thudswoosh.ogg', 50, 1, -1)
			visible_message("\red [M] has grabbed [src] passively!")
			return 1

		if("hurt")
			M.attack_log += text("\[[time_stamp()]\] <font color='red'>Punched [src.name] ([src.ckey])</font>")
			src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been punched by [M.name] ([M.ckey])</font>")

			log_attack("<font color='red'>[M.name] ([M.ckey]) punched [src.name] ([src.ckey])</font>")
			if(violence_need > 1)
				violence_need -= 20
				if(violence_need < 0)
					violence_need = 0


			var/damage = rand(0, 9)
			if(!damage)
				playsound(loc, 'punchmiss.ogg', 25, 1, -1)
				visible_message("\red <B>[M] has attempted to punch [src]!</B>")
				return 0
			var/datum/organ/external/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/armor_block = run_armor_check(affecting, "melee")

			if(M.mutations & HULK)	damage += 5
			playsound(loc, "punch", 25, 1, -1)

			visible_message("\red <B>[M] ������ [src] � [M.zone_sel.selecting]!</B>")

			if(dir == M.dir)
				damage += 4

			apply_damage(damage, BRUTE, affecting, armor_block)
			if(damage >= 9)
				visible_message("\red <B>�������� ������� ����!!</B>")
				apply_effect(4, WEAKEN, armor_block)
			UpdateDamageIcon()


		if("disarm")
			M.attack_log += text("\[[time_stamp()]\] <font color='red'>Disarmed [src.name] ([src.ckey])</font>")
			src.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been disarmed by [M.name] ([M.ckey])</font>")


			log_attack("<font color='red'>[M.name] ([M.ckey]) disarmed [src.name] ([src.ckey])</font>")


			if(w_uniform)
				w_uniform.add_fingerprint(M)
			var/datum/organ/external/affecting = get_organ(ran_zone(M.zone_sel.selecting))
			var/randn = rand(1, 100)
			if (randn <= 25)
				apply_effect(2, WEAKEN, run_armor_check(affecting, "melee"))
				playsound(loc, 'thudswoosh.ogg', 50, 1, -1)
				visible_message("\red <B>[M] ������� [src]!</B>")
				return

			if(randn <= 60)
				drop_item()
				playsound(loc, 'thudswoosh.ogg', 50, 1, -1)
				visible_message("\red <B>[M] ������� [src]!</B>")
				return

			playsound(loc, 'punchmiss.ogg', 25, 1, -1)
			visible_message("\red <B>[M] ��������&#255; �������� [src]!</B>")
	return


