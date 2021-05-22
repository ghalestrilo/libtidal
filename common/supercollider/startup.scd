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

(
~synths =
  [ [\reface, "reface CP", "reface CP MIDI 1"]
  , [\onyx, "Onyx Producer 2-2", "Onyx Producer 2-2 MIDI 1"]
  , [\mm, "MicroMonsta", "MicroMonsta MIDI 1"]
  , [\axo, "Axoloti Core", "Axoloti Core MIDI 1"]
  , [\mxd1, "minilogue xd", "minilogue xd MIDI 1"]
  , [\mxd2, "minilogue xd", "minilogue xd MIDI 2"]
  , [\mc, "Elektron Model:Cycles", "Elektron Model:Cycles MIDI 1"]
  ];
);







s.waitForBoot {
	~dirt = SuperDirt(2, s);
  s.sync;
	~dirt.loadSoundFiles("~/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples/*");
	~dirt.loadSoundFiles("~/samples/*");

	
	// ~dirt.start(57120, [0,2,4,6,8,10,12,14]);
	// ~dirt.start(57120, [0,2,4,6]);
  ~dirt.start(57120, [0]);

	MIDIClient.init;

	// Function for safely declaring midi devices to tidal
	~tidalMidiOut = { |tidal_name, device_name, channel_name|
		if (MIDIOut.findPort(device_name, channel_name) != nil, {
			~dirt.soundLibrary.addMIDI(tidal_name, MIDIOut.newByName(device_name, channel_name).latency = 0.04);
		});
	};

  ~synths.do({ |item|
    ("Connecting" + item[0]).postln;
    ~tidalMidiOut.value(item[0], item[1], item[2]);
  });

	if (~usesoftsynths == true, {
		~tidalMidiOut.value(\sco0, "SuperCollider", "in0");
		~tidalMidiOut.value(\sco1, "SuperCollider", "in1");
	});

  // Load Additional Scripts (if any)
  (
    ~bootscripts = PathName("~/.config/SuperCollider/").files;
    ~bootscripts.do({ |file|
      ~script = file.fullPath;
      if(~script.endsWith(".scd") && ~script.contains("startup.scd").not, {
        ("Including: " + ~script).postln;
          ~script.load;
        });
      });
  )
};

s.latency = 0;
