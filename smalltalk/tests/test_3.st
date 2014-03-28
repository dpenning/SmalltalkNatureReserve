(FileStream open: 'classes.st' mode: 'r') fileIn . !
"Test placing animals on grid and the tools to find if they are on the grid."
"If no error messages are printed, it is good."
|a b grid|
        'If no error messages are printed, test3 succeeded.' printNl .
	a := Rabbit new .
	b := Lynx new .
	grid := Grid new .

	grid place:a row:1 col:1 .
	grid place:b row:1 col:1 .

	((grid getLynxesAtRow:1 col:1) = 1) ifFalse: ['Lynx not placed into grid' printNl] .
	((grid getRabbitsAtRow:1 col:1) = 1) ifFalse: ['Rabbits not placed into grid' printNl] .

	grid remove:a row:1 col:1 .
	grid remove:b row:1 col:1 .

	((grid getLynxesAtRow:1 col:1) = 0) ifFalse: ['Lynx not placed into grid' printNl] .
	((grid getRabbitsAtRow:1 col:1) = 0) ifFalse: ['Rabbits not placed into grid' printNl] .
!
