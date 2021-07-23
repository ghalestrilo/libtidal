// Call amidiauto on boot
s.waitForBoot({
      var p, l;
      p = Pipe.new("amidiauto", "r");            // list directory contents in long format
      l = p.getLine;                         // get the first line
      while({l.notNil}, {l.postln; l = p.getLine; });    // post until l = nil
      p.close;                    // close the pipe to avoid that nasty buildup
})