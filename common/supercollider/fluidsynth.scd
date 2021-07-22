// Find Fluidsynth by name and connect
s.waitForBoot({
	MIDIClient.destinations.do({ |dest|
		if(dest.device.containsi("FLUID"),
			{
				"is fluidsynth (connecting)".postln;
				~tidalMidiOut.value(\fs, dest.device, dest.name)
			},
			// { "is not fluidsynth".postln }
		)
	})
})