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
// OSCdef(\controltidal, { arg msg; msg.postln; ~tidalctrl.sendMsg("/ctrl", *msg); }, '/ctrl', NetAddr.localAddr );

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
			// ~inst = MIDIOut.newByName(device_name, channel_name);
			// ~dirt.soundLibrary.addMIDI(tidal_name, ~inst);
			// ~inst.latency = 0.04;
			~dirt.soundLibrary.addMIDI(tidal_name, MIDIOut.newByName(device_name, channel_name).latency = 0.04);
			// FIXME: I think this is a bug. All midis will map to the same instrument
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

	// Send knobs to tidal slots
	// Send Slots: Control what virtual (tidal) modules will be sent cc to
	(
		MIDIIn.connectAll;
		~send_slots = [];
		~cycles_kbd_offset = 1 - 52;
		MIDIFunc.cc({ |val,num,chan,src|
			if(src == 1310720, {
				~send_slots.do({ |slotnum|
					~dest = ["slot", slotnum, num].join("_");
					~tidalctrl.sendMsg("/ctrl", ~dest, val);
					// [~dest, " = ", val].postln; // TODO: If Debug
				});
			});
		});
		MIDIFunc.noteOn( { |val,num,chan,src|
			if(src == 1310720, {
				// ("pushing"   + num).postln;
				~send_slots = (~send_slots ++ [~cycles_kbd_offset + num]).as(Set).as(Array).sort;
			});
		});
		MIDIFunc.noteOff( { |val,num,chan,src|
			if(src == 1310720, {
				// ("pushing"   + num).postln;
				~send_slots = ~send_slots.replace(~cycles_kbd_offset + num, nil).as(Set).as(Array).sort;
			});
		});
	);




	// ------------------------------------------------------------------------------------------------------------- TODO: IMPORT sc-mi.scd
	(
		SynthDef(\braids, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,timbre=0.5,color=0.5,model=0|
			var envLength = sustain*(end-begin)/speed;
			var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
			var env = Env.asr;
			var volume = IEnvGen.ar(env, line);
			var sig;

			freq = max(0, freq * speed * (1 + (accelerate * line)));
			sig = MiBraids.ar(pitch: freq.cpsmidi, timbre: timbre, color: color, model: model);

			Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
		}).add;
	);

	(
		SynthDef(\omi, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0|
			var envLength = sustain*(end-begin)/speed;
			var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
			var env = Env.asr;
			var volume = IEnvGen.ar(env, line);
			var sig;

			freq = max(0, freq * speed * (1 + (accelerate * line)));
			sig = MiOmi.ar(pit: freq.cpsmidi);

			Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
		}).add;
	);

	(
		SynthDef(\plaits, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,
			timbre=0.5,engine=0,harm=0.5,morph=0.5,level=1,lpgdecay=0,lpgcolour=0|
			var envLength = sustain*(end-begin)/speed;
			var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
			var env = Env.asr;
			var volume = IEnvGen.ar(env, line);
			var sig;

			freq = max(0, freq * speed * (1 + (accelerate * line)));
			sig = MiPlaits.ar(
				pitch: freq.cpsmidi,
				timbre: timbre,
				harm: harm,
				engine: engine,
				morph: morph,
				level: level,
				decay: lpgdecay,
				lpg_colour: lpgcolour,
			);

			Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
		}).add;
	);

	(
		SynthDef(\tides, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,tidesshape=0.5,slope=0.5,tidessmooth=0.5,shift=0.5,mode=2|
			var envLength = sustain*(end-begin)/speed;
			var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
			var env = Env.asr;
			var volume = IEnvGen.ar(env, line);
			var sig;

			freq = max(0, freq * speed * (1 + (accelerate * line)));
			sig = MiTides.ar(
				freq: freq,
				shape: tidesshape,
				slope: slope,
				smooth: tidessmooth,
				shift: shift,
				output_mode: mode,
				ramp_mode: 1,
				rate: 1
			);

			Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
		}).add;
	);

	(
		~dirt.addModule('elements', { |dirtEvent|
			dirtEvent.sendSynth('elements' ++ ~dirt.numChannels,
				[
					elementspitch: ~elementspitch,
					elementsstrength: ~elementsstrength,
					elementscontour: ~elementscontour,
					elementsbowlevel: ~elementsbowlevel,
					elementsblowlevel: ~elementsblowlevel,
					elementsstrikelevel: ~elementsstrikelevel,
					elementsflow: ~elementsflow,
					elementsmallet: ~elementsmallet,
					elementsbowtimb: ~elementsbowtimb,
					elementsblowtimb: ~elementsblowtimb,
					elementsstriketimb: ~elementsstriketimb,
					elementsgeom: ~elementsgeom,
					elementsbright: ~elementsbright,
					elementsdamp: ~elementsdamp,
					elementspos: ~elementspos,
					elementsspace: ~elementsspace,
					elementsmodel: ~elementsmodel,
					elementseasteregg: ~elementseasteregg,
					out: ~out
				]
			)
		}, {~elementsstrength.notNil});
	);

	(
		SynthDef("elements" ++ ~dirt.numChannels, {|out,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,
			elementspitch=48, elementsstrength=0.5, elementscontour=0.2, elementsbowlevel=0,elementsblowlevel=0, elementsstrikelevel=0,
			elementsflow=0.5, elementsmallet=0.5, elementsbowtimb=0.5, elementsblowtimb=0.5,
			elementsstriketimb=0.5, elementsgeom=0.25, elementsbright=0.5, elementsdamp=0.7, elementspos=0.2, elementsspace=0.3, elementsmodel=0,
			elementseasteregg=0|
			var signal = In.ar(out, ~dirt.numChannels);
			ReplaceOut.ar(out, MiElements.ar(
				blow_in: signal,
				strike_in: signal,
				gate: 1,
				pit: elementspitch,
				strength: elementsstrength,
				contour: elementscontour,
				bow_level: elementsbowlevel,
				blow_level: elementsblowlevel,
				strike_level: elementsstrikelevel,
				flow: elementsflow,
				mallet: elementsmallet,
				bow_timb: elementsbowtimb,
				blow_timb: elementsblowtimb,
				strike_timb: elementsstriketimb,
				geom: elementsgeom,
				bright: elementsbright,
				damp: elementsdamp,
				pos: elementspos,
				space: elementsspace,
				model: elementsmodel,
				easteregg: elementseasteregg
			));
		}).add;
	);

	(
		~dirt.addModule('mu', { |dirtEvent|
			dirtEvent.sendSynth('mu' ++ ~dirt.numChannels,
				[ mu: ~mu, out: ~out ]
			)
		}, {~mu.notNil});
	);

	(
		SynthDef("mu" ++ ~dirt.numChannels, {|out,mu=0|
			var signal = In.ar(out, ~dirt.numChannels);
			ReplaceOut.ar(out, MiMu.ar(signal, mu));
		}).add;
	);

	(
		~dirt.addModule('rings', { |dirtEvent|
			dirtEvent.sendSynth('rings' ++ ~dirt.numChannels,
				[
					ringstrig: ~ringstrig,
					ringsfreq: ~ringsfreq,
					ringsstruct: ~ringsstruct,
					ringsbright: ~ringsbright,
					ringsdamp: ~ringsdamp,
					ringspos: ~ringspos,
					ringsmodel: ~ringsmodel,
					ringspoly: ~ringspoly,
					ringsinternal: ~ringsinternal,
					ringseasteregg: ~ringseasteregg,
					out: ~out
				]
			)
		}, {~ringsbright.notNil});
	);

	(
		SynthDef("rings" ++ ~dirt.numChannels, { |out, ringsfreq=440,ringsstruct=0,ringsbright=0,ringsdamp=0.5,ringspos=0,ringsmodel=0,ringspoly=0,ringsinternal=0,ringseasteregg=0,ringsbypass=0|
			var signal = In.ar(out, ~dirt.numChannels);
			signal = MiRings.ar(
				signal,
				trig: ringsinternal,
				pit: ringsfreq.cpsmidi,
				struct: ringsstruct,
				bright: ringsbright,
				damp: ringsdamp,
				pos: ringspos,
				model: ringsmodel,
				poly: ringspoly,
				intern_exciter: ringsinternal,
				easteregg: ringseasteregg
			);
			ReplaceOut.ar(out, signal)
		}).add;

	);

	(
		~dirt.addModule('ripples', { |dirtEvent|
			dirtEvent.sendSynth('ripples' ++ ~dirt.numChannels,
				[
					ripplescf: ~ripplescf,
					ripplesreson: ~ripplesreson,
					ripplesdrive: ~ripplesdrive,
					out: ~out
				]
			)
		}, {~ripplescf.notNil});
	);

	(
		SynthDef("ripples" ++ ~dirt.numChannels, { |out, ripplescf=0, ripplesreson=0, ripplesdrive=1|
			var signal = In.ar(out, ~dirt.numChannels);
			signal = MiRipples.ar(
				signal,
				cf: ripplescf,
				reson: ripplesreson,
				drive: ripplesdrive,
			);
			ReplaceOut.ar(out, signal)
		}).add;

	);


	(

		(1..SuperDirt.maxSampleNumChannels).do { |numChannels|

			SynthDef("global_mi_verb" ++ numChannels, { |dryBus, effectBus, verbwet=0, verbtime=0, verbdamp=0, verbhp=0, verbfreeze=0, verbdiff=0.625, verbgain=0|
				var signal = In.ar(dryBus, ~dirt.numChannels);
				Out.ar(effectBus, MiVerb.ar(
					signal,
					verbtime,
					verbwet,
					verbdamp,
					verbhp,
					verbfreeze,
					verbdiff
				) * verbgain);
			}, [\ir, \ir]).add;

			SynthDef("global_mi_clouds" ++ numChannels, { |dryBus, effectBus, cloudspitch=0, cloudspos=0, cloudssize=0, cloudsdens=0, cloudstex=0, cloudswet=0, cloudsgain=0, cloudsspread=0, cloudsrvb=0, cloudsfb=0, cloudsfreeze=0, cloudsmode=0, cloudslofi=0|
				var signal = In.ar(dryBus, ~dirt.numChannels);
				Out.ar(effectBus, MiClouds.ar(
					inputArray: signal,
					pit: cloudspitch,
					pos: cloudspos,
					size: cloudssize,
					dens: cloudsdens,
					tex: cloudstex,
					drywet: cloudswet,
					in_gain: cloudsgain,
					spread: cloudsspread,
					rvb: cloudsrvb,
					fb: cloudsfb,
					freeze: cloudsfreeze,
					mode: cloudsmode,
					lofi: cloudslofi
				));
			}, [\ir, \ir]).add;
		};

	);

	// ------------------------------------------------------------------------------------------------------------- / TODO: IMPORT sc-mi.scd


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
};

s.latency = 0;