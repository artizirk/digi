#!/bin/bash
set -x -e
#ARGS='--ieee=synopsys'
ARGS=''
# import vhd files
ghdl -a -g $ARGS mult*.vhd
# make unit
ghdl -m $ARGS test
# run unit and export logic graph
ghdl -r $ARGS test --wave=test.ghw --stop-time=1us
# send signal to gtkwave to reload open file
gsettings set com.geda.gtkwave reload 0
