/obj/item/clothing/head/helmet/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat0_yellow"
	flags = FPRINT | TABLEPASS | SUITSPACE
	item_state = "hardhat0_yellow"
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	color_hyalor = "yellow" //Determines used sprites: hardhat[on]_[color_hyalor] and hardhat[on]_[color_hyalor]2 (lying down sprite)
	armor = list(melee = 30, bullet = 5, laser = 20,energy = 10, bomb = 20, bio = 10, rad = 20)

/obj/item/clothing/head/helmet/hardhat/orange
	icon_state = "hardhat0_orange"
	item_state = "hardhat0_orange"
	color_hyalor = "orange"

/obj/item/clothing/head/helmet/hardhat/red
	icon_state = "hardhat0_red"
	item_state = "hardhat0_red"
	color_hyalor = "red"

/obj/item/clothing/head/helmet/hardhat/white
	icon_state = "hardhat0_white"
	item_state = "hardhat0_white"
	color_hyalor = "white"

/obj/item/clothing/head/helmet/hardhat/dblue
	icon_state = "hardhat0_dblue"
	item_state = "hardhat0_dblue"
	color_hyalor = "dblue"