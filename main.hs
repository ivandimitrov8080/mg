#!/usr/bin/env runghc

import Euterpea

n x = x 4 qn

p x = [x 4 dqn]

abcSong = playDev 2 $ line (map n [c, c, g, g, a, a] ++ p g ++ map n [f, f, e, e, d, d] ++ p c ++ map n [g, g, f, e, e] ++ p d ++ map n [g, g, f, e, e] ++ p d ++ map n [c, c, g, g, a, a] ++ p g ++ map n [f, f, e, e, d, d] ++ p c)

main = abcSong
