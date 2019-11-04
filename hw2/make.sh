#!/bin/bash
set -x -e
# import vhd files
ghdl -i -g *.vhd
# make unit
ghdl -m test
# run unit and export logic graph
ghdl -r test --wave=test.ghw --stop-time=200ns
# send signal to gtkwave to reload open file
gsettings set com.geda.gtkwave reload 0
