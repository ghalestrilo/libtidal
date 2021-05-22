
~mod1 = 15;
~mod2 = 16;

~action = {  };
~section = {  };
~section = {  };


	// Send knobs to tidal slots
	// Send Slots: Control what virtual (tidal) modules will be sent cc to

s.waitForBoot {
    if (MIDIOut.findPort("Elektron Model:Cycles", "Elektron Model:Cycles MIDI 1") != nil, {
      // ~dirt.soundLibrary.addMIDI(tidal_name, MIDIOut.newByName(device_name, channel_name).latency = 0.04);
      (
        MIDIIn.connectAll;
        ~send_slots = [];
        ~cycles_kbd_offset = 1 - 52;
        MIDIFunc.cc({ |val,num,chan,src|
          if(src == 1310720, {
            ~send_slots.do({ |slotnum|
              ~dest = ["slot", slotnum, num].join("_");
              ~tidalctrl.sendMsg("/ctrl", ~dest, val);
              // [~dest, " = ", val].postln; // TODO: If Debug
            });
          });
        });
        MIDIFunc.noteOn( { |val,num,chan,src|
          if(src == 1310720, {
            // ("pushing"   + num).postln;
            ~send_slots = (~send_slots ++ [~cycles_kbd_offset + num]).as(Set).as(Array).sort;
          });
        });
        MIDIFunc.noteOff( { |val,num,chan,src|
          if(src == 1310720, {
            // ("pushing"   + num).postln;
            ~send_slots = ~send_slots.replace(~cycles_kbd_offset + num, nil).as(Set).as(Array).sort;
          });
        });
      );
		});
}