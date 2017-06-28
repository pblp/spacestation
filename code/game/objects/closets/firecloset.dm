/obj/structure/closet/firecloset/full/New()
	..()
	sleep(4)
	contents = list()

	new /obj/item/clothing/suit/fire/firefighter(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/device/flashlight(src)
	new /obj/item/weapon/tank/oxygen/red(src)
	new /obj/item/weapon/extinguisher(src)
	new /obj/item/clothing/head/helmet/hardhat/red(src)

/obj/structure/closet/firecloset/New()
	..()

	new /obj/item/clothing/suit/fire/firefighter(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/weapon/tank/oxygen/red(src)
	new /obj/item/weapon/extinguisher(src)
	new /obj/item/clothing/head/helmet/hardhat/red(src)

	/*switch (pickweight(list("nothing" = 5, "bare-bones" = 35, "basic" = 40, "pickpocketed" = 10, "untouched" = 10)))
		if ("nothing")
			//better luck next time
		if ("bare-bones")
			new /obj/item/weapon/extinguisher(src)
		if ("basic")
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/weapon/tank/emergency_oxygen(src)
			new /obj/item/weapon/extinguisher(src)
		if ("pickpocketed")   //suit got stolen
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/weapon/tank/oxygen(src)
			new /obj/item/weapon/extinguisher(src)
			new /obj/item/clothing/head/helmet/hardhat/red(src)
		if ("untouched")
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/weapon/tank/oxygen(src)
			new /obj/item/weapon/extinguisher(src)
			new /obj/item/clothing/suit/fire/firefighter(src)
			new /obj/item/clothing/head/helmet/hardhat/red(src)*/

/obj/structure/closet/toolcloset/New()
	if(prob(40))
		new /obj/item/clothing/suit/hazardvest(src)
	if(prob(70))
		new /obj/item/device/flashlight(src)
	if(prob(70))
		new /obj/item/weapon/screwdriver(src)
	if(prob(70))
		new /obj/item/weapon/wrench(src)
	if(prob(70))
		new /obj/item/weapon/weldingtool(src)
	if(prob(70))
		new /obj/item/weapon/crowbar(src)
	if(prob(70))
		new /obj/item/weapon/wirecutters(src)
	if(prob(70))
		new /obj/item/device/t_scanner(src)
	if(prob(20))
		new /obj/item/weapon/storage/belt/utility(src)
	if(prob(30))
		new /obj/item/weapon/cable_coil(src)
	if(prob(30))
		new /obj/item/weapon/cable_coil(src)
	if(prob(30))
		new /obj/item/weapon/cable_coil(src)
	if(prob(20))
		new /obj/item/device/multitool(src)
	if(prob(5))
		new /obj/item/clothing/gloves/yellow(src)
	if(prob(40))
		new /obj/item/clothing/head/helmet/hardhat(src)

/obj/structure/closet/radiation/New()
	..()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)