/mob/verb/check_skills(var/mob/living/carbon/human/user)
	set name = "Check"
	set category = "IC"
	usr << "<B>*---------*</B>"
	usr << "��� ���&#255;:"
	usr << "<B>����������� - [user.addiction]</B>"
	usr << "<B>������� - [user.age]</B>"
	usr << "<B>*---------*</B>"

/mob/verb/adminhelp(msg as text)
	set category = "Admin"
	set name = "Adminhelp"
	if(!usr.client.authenticated)
		src << "Please authorize before sending these messages."
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)

	if (!msg)
		return

	if (usr.client && usr.client.muted_complete)
		return

	for (var/mob/M in world)
		if (M.client && M.client.holder)
			if(M.client.sound_adminhelp)
				M << 'adminhelp.ogg'
			M << "\blue <b><font color=red>HELP: </font>[key_name(src, M)] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>PP</A>) (<A HREF='?src=\ref[M.client.holder];adminplayervars=\ref[src]'>VV</A>) (<A HREF='?src=\ref[M.client.holder];adminplayersubtlemessage=\ref[src]'>SM</A>) (<A HREF='?src=\ref[M.client.holder];adminplayerobservejump=\ref[src]'>JMP</A>) (<A HREF='?src=\ref[M.client.holder];secretsadmin=check_antagonist'>CA</A>):</b> [msg]"

	usr << "Your message has been broadcast to administrators."
	log_admin("HELP: [key_name(src)]: [msg]")
	if(tension_master)
		tension_master.new_adminhelp()
	send2irc(usr.ckey, msg)
	return

proc/send2irc(msg,msg2)
	if(config.useircbot)
		shell("python nudge.py [msg] [msg2]")
	return