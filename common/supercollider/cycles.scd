MIDIIn.connectAll;

~mod1 = 15;
~mod2 = 16;

~action = {  };
~section = {  };
~section = {  };


	// Send knobs to tidal slots
	// Send Slots: Control what virtual (tidal) modules will be sent cc to

s.waitForBoot {
    ~device = MIDIOut.findPort("Elektron Model:Cycles", "Elektron Model:Cycles MIDI 1");
    if (~device != nil, {
      (
        ~deviceid = ~device.uid;
        
        ~send_slots = [];
        ~cycles_kbd_offset = 1 - 52;
        MIDIFunc.cc({ |val,num,chan,src|
          // [val, num, chan, src].join(" ").postln;
          if(src == ~deviceid, {
            ~send_slots.do({ |slotnum|
              ~dest = ["slot", slotnum, num].join("_");
              ~tidalctrl.sendMsg("/ctrl", ~dest, val);
              [~dest, " = ", val].postln; // TODO: If Debug
            });
          });
        });
        MIDIFunc.noteOn( { |val,num,chan,src|
          if(src == ~deviceid, {
            // ("pushing"   + num).postln;
            ~send_slots = (~send_slots ++ [~cycles_kbd_offset + num]).as(Set).as(Array).sort;
          });
        });
        MIDIFunc.noteOff( { |val,num,chan,src|
          if(src == ~deviceid, {
            // ("pushing"   + num).postln;
            ~send_slots = ~send_slots.replace(~cycles_kbd_offset + num, nil).as(Set).as(Array).sort;
          });
        });
      );
		});
}
