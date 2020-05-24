~portonyx = MIDIOut.findPort("reface CP", "reface CP MIDI 1");
~portreface = MIDIOut.findPort("Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
~portmm = MIDIOut.findPort("MicroMonsta", "MicroMonsta MIDI 1");

Quarks.update("SuperDirt");
include("SuperDirt");

s.options.device_("JackRouter");
s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 * 16;
s.options.maxNodes = 1024 * 64;

s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 0;

OSCdef(\controltidal, { arg msg; NetAddr.new("localhost", 6010).sendMsg("/ctrl", *msg); }, '/ctrl', NetAddr.localAddr );

/*OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
}, '/play2', n);*/




// To Control Tidal
// Remember: msg is an array, containing fields
// OSCdef(\controltidal, { arg msg; NetAddr.new("localhost", 6010).sendMsg("/ctrl", /* cF name (hello) */, /* float value (0.1) */); }, '/ctrl', NetAddr.new("localhost", 8080));

s.waitForBoot {
	~dirt = SuperDirt();
	~dirt.loadSoundFiles("~/samples/*");
	~dirt.loadSoundFiles("~/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples/*");

	s.sync;
	~dirt.start(57120);

	MIDIClient.init;

	if (~portonyx != nil, {
		~reface = MIDIOut.newByName("reface CP", "reface CP MIDI 1");
		~dirt.soundLibrary.addMIDI(\reface, ~reface);
		~reface.latency = 0;
	});

	if (~portreface != nil, {
		~onyx = MIDIOut.newByName("Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
		~onyx.latency = 0;
		~dirt.soundLibrary.addMIDI(\onyx, ~onyx);
	});

	if (~portmm != nil, {
		~mm = MIDIOut.newByName("MicroMonsta", "MicroMonsta MIDI 1");
		~mm = MIDIOut(0, MIDIClient.destinations[1].uid);
		~mm.latency = 0;
		// MIDIClient.sources[4].connect(1);
		~dirt.soundLibrary.addMIDI(\mm, ~mm);
	});
};

s.latency = 0