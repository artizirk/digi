# instructions

x x x x 19

 Suvalise märgiga arvude vahetu korrutamine (s.o. operande ei teisendata korrutamistsükli ajaks positiivseteks).
Operandid on märgiga 2ndtäisarvud, mille pikkus ja neg. operandi kodeering (täiendkood/pöördkood) on antud   tehteoperandide tabelis.
Resultaat on sama pikkusega nagu operandid.
Algoritm peab korrektselt töötama suvaliste operandide korral (mis mahuvad etteantud formaati), mitte ainult modelleerimiseks/simuleerimiseks kasutatud operandide A1 A2 B1 B2 korral.
Algoritm peab tuvastama ka tehtetulemuse võimaliku ületäitumise. 

 x x x x 1 9

2ndoperandi ja tulemuse pikkus: 
10-järgulised märgiga täisarvud

negatiivne operand:
täiendkoodis
	
A1=-26
	
B1=15
	
A1=24
	
B1=-9


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
