#!/bin/bash

folder="$1"

# Run a Tidal Jam
tmux new-session -s jam "zsh -c \"nvim $JAM_PATH\""                      \; \
  new-window sclang                                                      \; \
  new-window 'cninjam 143.110.158.146:2049 -user anonymous:ghales -jack' \; \
  new-window 'fluidsynth "~/Chrono Trigger.sf2"'                         \; \
  select-window -t 0


#  new-window 'fluidsynth \"~/Chrono Trigger.sf2\"'                       \; \