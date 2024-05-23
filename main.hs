#!/usr/bin/env runghc

import Euterpea

p :: Octave -> Dur -> Music Pitch
p o d = rest 1

h :: (Octave -> Dur -> Music Pitch) -> Music Pitch
h x = x 4 qn

l :: (Octave -> Dur -> Music Pitch) -> Music Pitch
l x = x 2 qn

abcSong = playDev 2 $ tempo 4 (line (map h [c, c, g, g, a, a, g, p, f, f, e, e, d, d, c, p, g, g, f, e, e, d, p, g, g, f, e, e, d, p, c, c, g, g, a, a, g, p, f, f, e, e, d, d, c]))

lateralus = playDev 2 $ instrument AcousticGuitarSteel (line [d 2 qn, a 4 qn, g 4 sn, a 4 sn, a 4 en, c 4 qn, c 4 en, a 4 en, a 4 qn])

main = lateralus
