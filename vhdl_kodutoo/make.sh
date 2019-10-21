#!/bin/bash
set -x -e
ghdl -i -g *.vhd
ghdl -m test
ghdl -r test --wave=test.ghw --stop-time=200ns
gsettings set com.geda.gtkwave reload 0
