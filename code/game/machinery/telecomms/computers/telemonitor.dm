/*
	Telecomms monitor tracks the overall trafficing of a telecommunications network
	and displays a hierarchy of linked machines.
*/


/obj/machinery/computer/telecomms/monitor
	name = "telecommunications monitor"
	desc = "A monitor that tracks the overall traffic of a telecommunications network, and displays a hierarchy of linked machines."
	icon_screen = "comm_monitor"
	icon_keyboard = "green_key"
	icon_keyboard_emis = "green_key_mask"
	light_color = LIGHT_COLOR_GREEN

	var/screen = 0				// the screen number:
	var/list/machinelist = list()	// the machines located by the computer
	var/obj/machinery/telecomms/SelectedMachine

	var/network = "NULL"		// the network to probe

	var/temp = ""				// temporary feedback messages

/obj/machinery/computer/telecomms/monitor/attack_hand(mob/user as mob)
	if(stat & (BROKEN|NOPOWER))
		return
	user.set_machine(src)
	var/dat = "<center><b>Telecommunications Monitor</b></center>"

	switch(screen)


		// --- Main Menu ---

		if(0)
			dat += "<br>[temp]<br><br>"
			dat += "<br>Current Network: <a href='byond://?src=[REF(src)];network=1'>[network]</a><br>"
			if(machinelist.len)
				dat += "<br>Detected Network Entities:<ul>"
				for(var/obj/machinery/telecomms/T in machinelist)
					dat += "<li><a href='byond://?src=[REF(src)];viewmachine=[T.id]'>[REF(T)] [T.name]</a> ([T.id])</li>"
				dat += "</ul>"
				dat += "<br><a href='byond://?src=[REF(src)];operation=release'>\[Flush Buffer\]</a>"
			else
				dat += "<a href='byond://?src=[REF(src)];operation=probe'>\[Probe Network\]</a>"


		// --- Viewing Machine ---

		if(1)
			dat += "<br>[temp]<br>"
			dat += "<center><a href='byond://?src=[REF(src)];operation=mainmenu'>\[Main Menu\]</a></center>"
			dat += "<br>Current Network: [network]<br>"
			dat += "Selected Network Entity: [SelectedMachine.name] ([SelectedMachine.id])<br>"
			dat += "Linked Entities: <ol>"
			for(var/obj/machinery/telecomms/T in SelectedMachine.links)
				if(!T.hide)
					dat += "<li><a href='byond://?src=[REF(src)];viewmachine=[T.id]'>[REF(T.id)] [T.name]</a> ([T.id])</li>"
			dat += "</ol>"



	user << browse(HTML_SKELETON_TITLE("Telecommunications Monitor", dat), "window=comm_monitor;size=575x400")
	onclose(user, "server_control")

	temp = ""
	return


/obj/machinery/computer/telecomms/monitor/Topic(href, href_list)
	if(..())
		return


	add_fingerprint(usr)
	usr.set_machine(src)

	if(href_list["viewmachine"])
		screen = 1
		for(var/obj/machinery/telecomms/T in machinelist)
			if(T.id == href_list["viewmachine"])
				SelectedMachine = T
				break

	if(href_list["operation"])
		switch(href_list["operation"])

			if("release")
				machinelist = list()
				screen = 0

			if("mainmenu")
				screen = 0

			if("probe")
				if(machinelist.len > 0)
					temp = "<font color = #D70B00>- FAILED: CANNOT PROBE WHEN BUFFER FULL -</font>"

				else
					for(var/obj/machinery/telecomms/T in range(25, src))
						if(T.network == network)
							machinelist.Add(T)

					if(!machinelist.len)
						temp = "<font color = #D70B00>- FAILED: UNABLE TO LOCATE NETWORK ENTITIES IN \[[network]\] -</font>"
					else
						temp = "<font color = #336699>- [machinelist.len] ENTITIES LOCATED & BUFFERED -</font>"

					screen = 0


	if(href_list["network"])

		var/newnet = sanitize(input(usr, "Which network do you want to view?", "Comm Monitor", network) as null|text)
		if(newnet && (((usr in range(1, src)) || issilicon(usr))))
			if(length(newnet) > 15)
				temp = "<font color = #D70B00>- FAILED: NETWORK TAG STRING TOO LENGHTLY -</font>"

			else
				network = newnet
				screen = 0
				machinelist = list()
				temp = "<font color = #336699>- NEW NETWORK TAG SET IN ADDRESS \[[network]\] -</font>"

	updateUsrDialog()
	return

/obj/machinery/computer/telecomms/monitor/attackby(obj/item/attacking_item, mob/user)
	if(attacking_item.isscrewdriver())
		if(attacking_item.use_tool(src, user, 20, volume = 50))
			if (src.stat & BROKEN)
				to_chat(user, SPAN_NOTICE("The broken glass falls out."))
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				new /obj/item/material/shard( src.loc )
				var/obj/item/circuitboard/comm_monitor/M = new /obj/item/circuitboard/comm_monitor( A )
				for (var/obj/C in src)
					C.forceMove(src.loc)
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.anchored = 1
				qdel(src)
			else
				to_chat(user, SPAN_NOTICE("You disconnect the monitor."))
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				var/obj/item/circuitboard/comm_monitor/M = new /obj/item/circuitboard/comm_monitor( A )
				for (var/obj/C in src)
					C.forceMove(src.loc)
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.anchored = 1
				qdel(src)
	src.updateUsrDialog()
	return

/obj/machinery/computer/telecomms/monitor/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = 1
		to_chat(user, SPAN_NOTICE("You you disable the security protocols"))
		src.updateUsrDialog()
		return 1
