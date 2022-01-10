#!/bin/bash

folder="$1"

# Run a Tidal Jam
tmux new-session -s jam "zsh -c \"nvim.appimage $JAM_PATH\""                                \; \
  new-window sclang                                                                \; \
  new-window 'cninjam 143.110.158.146:2049 -user anonymous:ghales -jack'           \; \
  new-window 'fluidsynth "$HOME/soundfonts/Chrono Trigger.sf2" -a jack -o synth.audio-channels=16 -o audio.jack.multi=yes -o audio.jack.id=fluidsynth -o audio.jack.autoconnect=yes' \; \
  select-window -t 0

#  new-window 'fluidsynth "$HOME/soundfonts/Chrono Trigger.sf2" --connect-jack-outputs' \; \
# fluidsynth -a jack -o synth.audio-channels=16 -o audio.jack.multi=yes -o audio.jack.id=fluidsynth -o audio.jack.autoconnect=yes
#  new-window 'fluidsynth \"~/Chrono Trigger.sf2\"'                       \; \
