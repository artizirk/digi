#!/bin/bash
set -x -e
# import vhd files
ghdl -a -g --ieee=synopsys *.vhd
# make unit
ghdl -m --ieee=synopsys test
# run unit and export logic graph
ghdl -r --ieee=synopsys test --wave=test.ghw --stop-time=1us
# send signal to gtkwave to reload open file
gsettings set com.geda.gtkwave reload 0
