(FileStream open: 'animals_class.st' mode: 'r') fileIn . !
	| the_grid a b |
	the_grid := Grid new . 
	a := Rabbit new .
	b := Lynx new .

	the_grid place:a row:1 col:1 .
	the_grid place:b row:1 col:1 .

	the_grid getLynxesAtRow:1 Col:1 printNl .
	the_grid getRabbitsAtRow:1 Col:1 printNl .

	(the_grid debugRow:1 Col:1) printNl.

	the_grid remove:a row:1 col:1 .
	the_grid remove:b row:1 col:1 .

	(the_grid debugRow:1 Col:1) printNl.

	(the_grid getLynxesAtRow:1 Col:1) printNl .
	(the_grid getRabbitsAtRow:1 Col:1) printNl .
!