Quarks.update("SuperDirt");

//Quarks.install("FoxDot");
// FoxDot.start;

include("SuperDirt");

// s.options.device_("JackRouter");
SuperDirt.start();

OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
  NetAddr.new("localhost", 3333).sendMsg("/blender", *msg); // debug
}, '/play2', n);


MIDIClient.init;

~midiOut = MIDIOut.newByName("reface CP", "reface CP MIDI 1");

~midiOut.latency = 0;



// Run this manually once ~dirt finishes booting
~dirt.soundLibrary.addMIDI(\midi, ~midiOut);
