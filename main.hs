#!/usr/bin/env runghc

import Euterpea

n x = x 4 qn

beginner = playDev 2 $ line (map n [c, c, g, g, a, a, g])

main = do
  beginner
