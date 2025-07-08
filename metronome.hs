#!/usr/bin/env runghc

import Euterpea

-- Accented beat: higher pitch or longer duration
accentBeat :: Music Pitch
accentBeat = instrument Woodblock (note qn (C, 6))  -- accented click

-- Normal beat: softer/lower pitch
normalBeat :: Music Pitch
normalBeat = instrument Woodblock (note qn (C, 5))  -- regular click

-- One measure of n beats, with first beat accented
bar :: Int -> Music Pitch
bar n = line (accentBeat : replicate (n - 1) normalBeat)

-- Full metronome: takes BPM and beats per bar, and repeats
metronome :: Rational -> Int -> Music Pitch
metronome bpm beatsPerBar =
  tempo (bpm / 120) $ line (cycle [bar beatsPerBar])  -- repeat bar forever

-- Run: 4/4 at 100 BPM
main = playDev 2 $ metronome 80 4

