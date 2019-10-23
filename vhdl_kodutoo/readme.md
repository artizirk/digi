# programs

* ghdl-mcode
* gtkwave
* inotify-tools

# commands

Build vhdl files and run simulation
```
./make.sh
```

Open a gtkwave window to display results
```
gtkwave test.ghw -a test.gtkw &
```

Rebuild everything on vhdl file change
```
while true; do inotifywait -e modify *.vhd; ./make.sh; done
```
