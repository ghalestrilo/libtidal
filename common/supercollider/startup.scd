~usesoftsynths = false;

Quarks.update("SuperDirt");
include("SuperDirt");

s.options.device_("JackRouter");

s.options.memSize = 8192 * 16;
s.options.numBuffers = 1024 * 16;
s.options.maxNodes = 1024 * 64;

s.options.numOutputBusChannels = 8;
s.options.numInputBusChannels = 2;

OSCdef(\controltidal, { arg msg; NetAddr.new("localhost", 6010).sendMsg("/ctrl", *msg); }, '/ctrl', NetAddr.localAddr );

// Function for safely declaring midi devices to tidal
~tidalMidiOut = { |tidal_name, device_name, channel_name|
	if (MIDIOut.findPort(device_name, channel_name) != nil, {
		~dirt.soundLibrary.addMIDI(tidal_name, MIDIOut.newByName(device_name, channel_name));
		// TODO: Add .latency = 0
	});
};


s.waitForBoot {
	~dirt = SuperDirt(2, s);
	~dirt.loadSoundFiles("~/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples/*");
	~dirt.loadSoundFiles("~/samples/*");

	s.sync;
	// ~dirt.start(57120, [0,2,4,6,8,10,12,14]);
	~dirt.start(57120, [0,2,4,6]);

	MIDIClient.init;

	~tidalMidiOut.value(\reface, "reface CP", "reface CP MIDI 1");
	~tidalMidiOut.value(\onyx, "Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
	~tidalMidiOut.value(\mm, "MicroMonsta", "MicroMonsta MIDI 1");
	~tidalMidiOut.value(\axo, "Axoloti Core", "Axoloti Core MIDI 1");
	~tidalMidiOut.value(\mxd1, "minilogue xd", "minilogue xd MIDI 1");
	~tidalMidiOut.value(\mxd2, "minilogue xd", "minilogue xd MIDI 2");
	// ~tidalMidiOut.value(\smidi, "qmidiroute", "in");

	if (~usesoftsynths == true, {
		~tidalMidiOut.value(\sco0, "SuperCollider", "in0");
		~tidalMidiOut.value(\sco1, "SuperCollider", "in1");
	});


	// Connect Dualshock
	// if (HID.findBy(1356, 2508).size > 0) { ~dualshock = HID.open(1356, 2508); };
};

s.latency = 0


/*OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
}, '/play2', n);*/