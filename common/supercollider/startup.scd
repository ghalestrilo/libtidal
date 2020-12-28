~usesoftsynths = false;

Quarks.update("SuperDirt");
include("SuperDirt");

s.options.device_("JackRouter");

s.options.memSize = 8192 * 16;
s.options.numBuffers = 1024 * 16;
s.options.maxNodes = 1024 * 64;

s.options.numOutputBusChannels = 8;
s.options.numInputBusChannels = 2;

~tidalctrl = NetAddr.new("localhost", 6010);
OSCdef(\controltidal, { arg msg; msg.postln; ~tidalctrl.sendMsg("/ctrl", *msg); }, '/ctrl', NetAddr.localAddr );

s.waitForBoot {
	~dirt = SuperDirt(2, s);
	~dirt.loadSoundFiles("~/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples/*");
	~dirt.loadSoundFiles("~/samples/*");

	s.sync;
	// ~dirt.start(57120, [0,2,4,6,8,10,12,14]);
	~dirt.start(57120, [0,2,4,6]);

	// Function for safely declaring midi devices to tidal
	~tidalMidiOut = { |tidal_name, device_name, channel_name|
		if (MIDIOut.findPort(device_name, channel_name) != nil, {
			~dirt.soundLibrary.addMIDI(tidal_name, MIDIOut.newByName(device_name, channel_name));
			// TODO: Add .latency = 0
		});
	};

	MIDIClient.init;

	~tidalMidiOut.value(\reface, "reface CP", "reface CP MIDI 1");
	~tidalMidiOut.value(\onyx, "Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
	~tidalMidiOut.value(\mm, "MicroMonsta", "MicroMonsta MIDI 1");
	~tidalMidiOut.value(\axo, "Axoloti Core", "Axoloti Core MIDI 1");
	~tidalMidiOut.value(\mxd1, "minilogue xd", "minilogue xd MIDI 1");
	~tidalMidiOut.value(\mxd2, "minilogue xd", "minilogue xd MIDI 2");
	~tidalMidiOut.value(\mc, "Elektron Model:Cycles", "Elektron Model:Cycles MIDI 1");
	// ~tidalMidiOut.value(\smidi, "qmidiroute", "in");

	if (~usesoftsynths == true, {
		~tidalMidiOut.value(\sco0, "SuperCollider", "in0");
		~tidalMidiOut.value(\sco1, "SuperCollider", "in1");
	});

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
		if (MIDIOut.findPort("Axoloti Core", "Axoloti Core MIDI 1") != nil, {
			~axo = MIDIOut.newByName("Axoloti Core", "Axoloti Core MIDI 1");
			~senddskey = { |...args|
				~keyname = args[0];
				// TODO: redirect midi msg to axo
				(~keyname + " " + args[2]).postln;
				~tidalctrl.sendMsg("/ctrl", ~keyname, args[2]);
			};
		});


		// Forward Dualshock Input to appropriate inputs
		~dskey = { |n, keyname| HIDFunc.element({ |...args| ~senddskey.value(keyname, *args)}, [n]); };
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
};

s.latency = 0

/*


HIDFunc.element({ |...args| args[1].postln; }, [14]); //joystick(L3) X. 0:left, 255:right, center is unstable sometimes
HIDFunc.element({ |...args| args[1].postln; }, [15]); //joystick(L3) Y
HIDFunc.element({ |...args| args[1].postln; }, [16]); //joystick(R3) X
HIDFunc.element({ |...args| args[1].postln; }, [17]); //joystick(R3) Y

HIDFunc.element({ |...args| args[1].postln; }, [20]); //L2, 0-255 (Element #19 in Bluetooth)
HIDFunc.element({ |...args| args[1].postln; }, [21]); //R2, 0-255 (Element #20 in Bluetooth)


//Trackpad
//does not work in Bluetooth/wireless mode

HIDFunc.element({ }, 48);//touch timer
HIDFunc.element({  }, 49);//one finger on off counter
//off = on+128
//on range: 0-127 (off range 128-255)
HIDFunc.element({  }, 50); //x position tracker
HIDFunc.element({  }, 51); //X directions
HIDFunc.element({ }, 52);//Y position (0~58)
HIDFunc.element({  }, 53);//two finger on off
HIDFunc.element({ }, 54);//two finger x position
HIDFunc.element({ }, 55);//two finger y position (increase: down, decrease: up)
HIDFunc.element({ }, 56);//two finger y position

*/


/*OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
}, '/play2', n);*/