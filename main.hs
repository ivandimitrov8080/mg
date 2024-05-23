#!/usr/bin/env runghc

import Euterpea

beginner = playDev 2 $ line [c 4 qn, c 4 qn, g 4 qn, g 4 qn, a 4 qn, a 4 qn, g 4 hn]

main = do
  beginner
