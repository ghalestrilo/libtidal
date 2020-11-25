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


/*~soft = MIDIOut.newByName("qmidiroute", "in");
~soft.latency = -1;
~dirt.soundLibrary.addMIDI(\smidi, ~soft);*/

s.waitForBoot {
	~dirt = SuperDirt(2, s);
	~dirt.loadSoundFiles("~/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples/*");
	~dirt.loadSoundFiles("~/samples/*");

	s.sync;
	// ~dirt.start(57120, [0,2,4,6,8,10,12,14]);
	~dirt.start(57120, [0,2,4,6]);

	MIDIClient.init;

	~portreface = MIDIOut.findPort("reface CP", "reface CP MIDI 1");
	~portonyx   = MIDIOut.findPort("Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
	~portmm     = MIDIOut.findPort("MicroMonsta", "MicroMonsta MIDI 1");
	~portaxo    = MIDIOut.findPort("Axoloti Core", "Axoloti Core MIDI 1");


	if (~portreface != nil, {
		~reface = MIDIOut.newByName("reface CP", "reface CP MIDI 1");
		~dirt.soundLibrary.addMIDI(\reface, ~reface);
		~reface.latency = 0;
	});

	if (~portonyx != nil, {
		~onyx = MIDIOut.newByName("Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
		~onyx.latency = 0;
		~dirt.soundLibrary.addMIDI(\onyx, ~onyx);
	});

	if (~portmm != nil, {
		~mm = MIDIOut.newByName("MicroMonsta", "MicroMonsta MIDI 1");
		~mm.latency = 0;
		~dirt.soundLibrary.addMIDI(\mm, ~mm);
	});

	if (~portaxo != nil, {
		~axo = MIDIOut.newByName("Axoloti Core", "Axoloti Core MIDI 1");
		~axo.latency = 0;
		~dirt.soundLibrary.addMIDI(\axo, ~axo);
	});

	// TEMP
	~portxd1    = MIDIOut.findPort("minilogue xd", "minilogue xd MIDI 1"); // TEMP
	~portxd2    = MIDIOut.findPort("minilogue xd", "minilogue xd MIDI 2"); // TEMP
	if (~portmxd!= nil, {
		~mxd1 = MIDIOut.newByName("minilogue xd", "minilogue xd MIDI 1");
		~mxd1.latency = 0;
		~dirt.soundLibrary.addMIDI(\mxd1, ~mxd1);

		~mxd2 = MIDIOut.newByName("minilogue xd", "minilogue xd MIDI 2");
		~mxd2.latency = 0;
		~dirt.soundLibrary.addMIDI(\mxd2, ~mxd2);
	});


	if (~usesoftsynths == true, {
		~sco0 = MIDIOut.newByName("SuperCollider", "in0");
		~sco0.latency = 0;
		~dirt.soundLibrary.addMIDI(\sco0, ~sco0);

		~sco1 = MIDIOut.newByName("SuperCollider", "in1");
		~sco1.latency = 0;
		~dirt.soundLibrary.addMIDI(\sco1, ~sco1);
	});
};

s.latency = 0







// To Control Tidal
// Remember: msg is an array, containing fields
// OSCdef(\controltidal, { arg msg; NetAddr.new("localhost", 6010).sendMsg("/ctrl", /* cF name (hello) */, /* float value (0.1) */); }, '/ctrl', NetAddr.new("localhost", 8080));

/*OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
}, '/play2', n);*/