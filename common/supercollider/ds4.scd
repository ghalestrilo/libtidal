s.waitForBoot {

	// TODO: Move to separate file
	// Connect Dualshock
	// if (HID.findBy(1356, 2508).size > 0) { ~dualshock = HID.open(1356, 2508); };
	HID.findAvailable;
	if (HID.findBy(1356, 2508).size > 0, {
		~dualshock = HID.open(1356, 2508);

		// Send DualShock input to Tidal
		~senddskey = { |...args|
			~keyname = args[0];
			// TODO: redirect midi msg to axo
			(~keyname + " " + args[2]).postln;
			~tidalctrl.sendMsg("/ctrl", ~keyname, args[2]);
		};

							/*
					~axo.control(0, ctlNum: args[0], val: args[1]);
					~axo.control(1, ctlNum: args[0], val: args[1]);
					~axo.control(2, ctlNum: args[0], val: args[1]);
					~axo.control(3, ctlNum: args[0], val: args[1]);
					~axo.control(4, ctlNum: args[0], val: args[1]);
					~axo.control(5, ctlNum: args[0], val: args[1]);
					~axo.control(6, ctlNum: args[0], val: args[1]);
					~axo.control(7, ctlNum: args[0], val: args[1]);
					~axo.control(8, ctlNum: args[0], val: args[1]);
					~axo.control(9, ctlNum: args[0], val: args[1]);
					*/

		// If axoloti is present, send dualshock controls to it
		/*
		if (MIDIOut.findPort("Axoloti Core", "Axoloti Core MIDI 1") != nil, {
			~axo = MIDIOut.newByName("Axoloti Core", "Axoloti Core MIDI 1");
			~senddskey = { |...args|
				~keyname = args[0];
				// TODO: redirect midi msg to axo
				(~keyname + " " + args[2]).postln;
				~tidalctrl.sendMsg("/ctrl", ~keyname, args[2]);
			};
		});
		*/


		// Forward Dualshock Input to appropriate inputs
		// ~dskey = { |n, keyname| HIDFunc.element({ |...args| ~senddskey.value(keyname, *args)}, [n]); };
		// ~senddskey.value("haha", 0, 0, 0)


		/*
		HIDFunc.element({ |...args| args[1].postln; }, [0]); //joystick(L3) X. 0:left, 255:right, center is unstable sometimes
		HIDFunc.element({ |...args| args[1].postln; }, [1]); //joystick(L3) Y
		HIDFunc.element({ |...args| args[1].postln; }, [2]); //joystick(R3) X
		HIDFunc.element({ |...args| args[1].postln; }, [3]); //joystick(R3) Y
		*/

		/*
		~dskey.value(0,"joylx");
		~dskey.value(1,"joyly");
		~dskey.value(2,"joyrx");
		~dskey.value(3,"joyry");

		~dskey.value(4,"triangle");
		~dskey.value(5,"square");
		~dskey.value(6,"cross");
		~dskey.value(7,"circle");

		wrong
		~dskey.value(0,"square");
		~dskey.value(1,"cross");
		~dskey.value(2,"circle");
		~dskey.value(3,"triangle");
		*/

		// ~dskey.value(612,"sensor??");
		// ~dskey.value(613,"sensor??");

		// HIDFunc.element({ |...args| args[1].postln; }, (0..600));// blank

		/*
		HIDFunc.element({ |...args| args[1].postln; }, [8]); //Sharek
		HIDFunc.element({ |...args| args[1].postln; }, [9]); //Options
		HIDFunc.element({ |...args| args[1].postln; }, [10]); //L3
		HIDFunc.element({ |...args| args[1].postln; }, [11]); //R3
		HIDFunc.element({ |...args| args[1].postln; }, [12]); //PS button
		HIDFunc.element({ |...args| args[1].postln; }, [13]); //Trackpad Button
		*/
	});
}