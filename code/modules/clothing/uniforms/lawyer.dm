/*Contains most of the "Law" uniforms*/


/obj/item/clothing/under/lawyer
	desc = "Slick threads."
	name = "Lawyer suit"
	flags = FPRINT | TABLEPASS


/obj/item/clothing/under/lawyer/black
	icon_state = "lawyer_black"
	item_state = "lawyer_black"
	color_hyalor = "lawyer_black"


/obj/item/clothing/under/lawyer/red
	icon_state = "lawyer_red"
	item_state = "lawyer_red"
	color_hyalor = "lawyer_red"


/obj/item/clothing/under/lawyer/blue
	icon_state = "lawyer_blue"
	item_state = "lawyer_blue"
	color_hyalor = "lawyer_blue"


/obj/item/clothing/under/lawyer/bluesuit
	name = "Blue Suit"
	desc = "A classy suit and tie"
	icon_state = "bluesuit"
	item_state = "bluesuit"
	color_hyalor = "bluesuit"

/obj/item/clothing/suit/lawyer/bluejacket
	name = "Blue Suit Jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_blue_open"
	item_state = "suitjacket_blue_open"
	body_parts_covered = UPPER_TORSO|ARMS


/obj/item/clothing/under/lawyer/purpsuit
	name = "Purple Suit"
	icon_state = "lawyer_purp"
	item_state = "lawyer_purp"
	color_hyalor = "lawyer_purp"

/obj/item/clothing/suit/lawyer/purpjacket
	name = "Purple Suit Jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_purp"
	item_state = "suitjacket_purp"
	body_parts_covered = UPPER_TORSO|ARMS


/obj/item/clothing/suit/judgerobe
	name = "judge's robe"
	desc = "This robe commands authority."
	icon_state = "judge"
	item_state = "judge"
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	allowed = list(/obj/item/weapon/cigpacket,/obj/item/weapon/spacecash)
