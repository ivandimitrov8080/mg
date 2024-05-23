#!/usr/bin/env runghc

import Euterpea

p :: Octave -> Dur -> Music Pitch
p o d = rest 1

n :: (Octave -> Dur -> Music Pitch) -> Music Pitch
n x = x 4 wn

abcSong = playDev 2 $ tempo 4 (line (map n [c, c, g, g, a, a, g, p, f, f, e, e, d, d, c, p, g, g, f, e, e, d, p, g, g, f, e, e, d, p, c, c, g, g, a, a, g, p, f, f, e, e, d, d, c]))

main = abcSong
