~useonyx = false;
~usereface = false;

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

	if (~usereface == true, {
		~reface = MIDIOut.newByName("reface CP", "reface CP MIDI 1");
		~dirt.soundLibrary.addMIDI(\reface, ~reface);
		~reface.latency = 0;
	});

	if (~useonyx == true, {
		~onyx = MIDIOut.newByName("Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1");
		~onyx.latency = 0;
		~dirt.soundLibrary.addMIDI(\onyx, ~onyx);
	});
};

s.latency = 0