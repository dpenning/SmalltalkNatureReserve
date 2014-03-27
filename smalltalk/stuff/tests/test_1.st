(FileStream open: 'classes.st' mode: 'r') fileIn . !
" test routines for nature-reserve simulator "

|aLynx aGrid simulation|
	aLynx := Lynx new .
	'lynx id ' print .
		aLynx getID printNl . 
	aGrid := Grid new .
	'should be no lynxes here: ' print.
		(aGrid getLynxesAtRow: 1 col: 1 ) printNl .
	aGrid place: aLynx row: 1 col: 1 .
	'should be one lynx here: ' print.
		(aGrid getLynxesAtRow: 1 col: 1 ) printNl .

	simulation := Simulation new .
	simulation setup .
	simulation status .
	simulation step status .
	simulation step status .
!

		
