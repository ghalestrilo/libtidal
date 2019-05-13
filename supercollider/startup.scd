include("SuperDirt");
SuperDirt.start();
OSCdef(\forward_signal_to_blender, {
  arg msg;
  NetAddr.new("localhost", 9001).sendMsg("/blender", *msg); // blender
  NetAddr.new("localhost", 3333).sendMsg("/blender", *msg); // debug
}, '/play2', n)
