# programs

* ghdl-mcode
* gtkwave
* inotify-tools

# commands

```
./make.sh
```

```
gtkwave test.ghw -a test.gtkw &
```

```
while true; do inotifywait -e modify *.vhd; ./make.sh; done
```
