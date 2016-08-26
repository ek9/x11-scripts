#!/usr/bin/env bash
## ek9/x11-scripts - https://github.com/ek9/x11-scripts
find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete
