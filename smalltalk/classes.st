" David Pennington & Nick Graczyk
This is the classes file for the program. This file builds 3 classes
	- Animal : the animal class that serves as the base class for ...
		- Rabbit : the rabbit subclass.
		- Lynx : the lynx subclass.
	- Grid : the class that stores the grid for the nature preserve.
	- Simulation : the class that wraps around Grid and controls
	the simulation.
"

Object subclass: #Animal .
Animal instanceVariableNames: 'active_grid active row column direction ID' .
Animal class instanceVariableNames: 'currentID' .
Animal comment: 'This is an animal.' .

Animal class extend [
	new [
		| temp |
		temp := super new . 
		temp init. 
		^temp
	]
	getCount [
		"manage the class instance variable with this function"
		currentID ifNil: [currentID := 0].
		currentID := (currentID + 1). 
		^currentID
	]
]
Animal extend [
	init [
		"We use active_grid to tell us which grid location the animal is
		active in. This is needed for act with no parameters"
		active_grid := nil .
		active := false.
		row := -1.
		column := -1.
		self setDirection:((1 to: 4) atRandom) . 
		ID := Animal getCount.
	]
	setGrid:new_grid [active_grid := new_grid]
	getGrid [^active_grid]
	getActive [ ^active ]
	activate [ active := true ]
	deactivate [ active := false ]
	setRow:r [ row := r ]
	setCol:c [ column := c ]
	getID [ ^ID ]
	getRow [ ^row ]
	getCol [ ^column ]
	getDirection [ ^direction ]
	setDirection:new_dir [ direction := new_dir ]
	move [
		(direction == 1) ifTrue: [
			"up"
			(row == 1) ifTrue: [row := 10] ifFalse: [row := (row-1)].
		] .
		(direction == 2) ifTrue: [
			"down"
			(row == 10) ifTrue: [row := 1] ifFalse: [row := (row+1)].
		] .
		(direction == 3) ifTrue: [
			"left"
			(column == 1) ifTrue: [column := 10] ifFalse: [column := (column-1)].
		] .
		(direction == 4) ifTrue: [
			"right"
			(column == 10) ifTrue: [column := 1] ifFalse: [column := (column+1)].
		] .
		self setDirection:((1 to: 4) atRandom) .
	]
	printOn: stream [
		"print ID, row and column for debugging purposes"
		super printOn: stream.
		stream nextPutAll: '(' .
		ID printOn: stream.
		stream nextPutAll: ',' .
		stream nextPutAll: ' (' .
		row printOn: stream.	
		stream nextPutAll: ',' .
		column printOn: stream.
		stream nextPutAll: ')' .
		stream nextPutAll: ' )' .
	]
]

Animal subclass: #Rabbit.

Rabbit extend [
	"To match the function signature specified, we store the Grid Location"
	act [self actWithGrid:(self getGrid)]
	actWithGrid:g [
		((g getRabbitsAtRow: (self getRow) col: (self getCol)) >= 10) ifTrue: [
			g remove:self row:(self getRow) col:(self getCol) . 
		] ifFalse: [
			((g getRabbitsAtRow: (self getRow) col: (self getCol)) > 1) ifTrue: [
				(1 to:2) do: [:a | g place:(Rabbit new) row:(self getRow) col:(self getCol)] . 
			].
		].
	]
]

Animal subclass: #Lynx.

Lynx extend[
	act [self actWithGrid:(self getGrid)]
	actWithGrid:g [
		((g getRabbitsAtRow:(self getRow) col:(self getCol)) > 0) ifTrue: [
			g remove:((g getListAtRow:(self getRow) Col: (self getCol)) detect: [:a | a class = Rabbit] ifNone:[nil]) row:(self getRow) col:(self getCol) .
			g place:(Lynx new) row:(self getRow) col:(self getCol) .
		] ifFalse: [
			g remove:self row:(self getRow) col:(self getCol) .
		].
	]
]

Object subclass: #Grid .
Grid instanceVariableNames: 'gridArray' .
Grid class instanceVariableNames: '' .
Grid comment: 'This class defines the grid. Meant to exist inside a simulation but can exist outside.' .

Grid class extend [
	new [
		| temp |
		temp := super new . 
		temp init. 
		^temp
	]
]
Grid extend [
	"The grid is implemented as a list from which we select the correct animal."
	init [
		| x y |
		gridArray := OrderedCollection new . 
		(1 to: 10) do: [ :a | 
			x := OrderedCollection new . 
			(1 to: 10) do: [ :b | 
				y := OrderedCollection new .
				x add: y . 
			] .
			gridArray add: x . 
		]
	]
	getActiveAtRow:r Col:c [
		"Returns an active animal at a location to act."
		^(((gridArray at:r) at:c) detect: [ :a | (a getActive)] ifNone:[nil])
	]
	getLynxesAtRow:r col:c [
		"Count the number of lynxes at a location."
		^((((gridArray at:r) at:c) select: [:a | a class = Lynx]) size)
	]
	getRabbitsAtRow:r col:c [
		"Count the number of rabbits at a location."
		^((((gridArray at:r) at:c) select: [:a | a class = Rabbit]) size)
	]
	place:animal row:r col:c [
		"Puts an animal at r,c"
		animal setRow:r .
		animal setCol:c .
		((gridArray at:r) at:c) addLast:animal .
	]
	remove:animal row:r col:c [
		"First get the location of the animal in the gridArray"
		^(((gridArray at:r) at:c) remove: animal ifAbsent: []) .
	]
	getListAtRow:r Col:c [
		^((gridArray at:r) at:c) 
	]
	makeAllActive [
		"Iterate over all animals and make all of them active."
		(1 to: 10) do: [ :a | 
			(1 to: 10) do: [ :b | 
				((gridArray at:a) at:b) do: [ :c | c activate ].
			] .
		] .
	]
]

Object subclass: #Simulation .
Simulation instanceVariableNames: 'grid month' .
Simulation class instanceVariableNames: '' .
Simulation comment: 'our simulation' .

Simulation class extend [
	new [
		| temp |
		temp := super new . 
		temp init. 
		^temp
	]
]

Simulation extend [
	init [
		month := 0 .
		grid := Grid new .
	]
	setup [
		"Setup 50 rabbits and 10 lynxes per assignment specification."
		(1 to:50) do: [ :a |
			| x y new_rabbit |
				x := (1 to:10) atRandom .
				y := (1 to:10) atRandom .
				new_rabbit := Rabbit new .
				grid place:new_rabbit row:x col:y .
		].
		(1 to:10) do: [ :a |
			| x y new_lynx |
				x := (1 to:10) atRandom .
				y := (1 to:10) atRandom .
				new_lynx := Lynx new .
				grid place:new_lynx row:x col:y .
		].
	]
	printOn: stream [
		"Print the current state of the simulation in a easily viewable format."
		"Lynxes are on top in each cell, rabbits are on the bottom."
		|temp_string|
		stream nextPutAll: '------------------------ month: ' .
		temp_string := (month asString) . 
		[(temp_string size) < 4] whileTrue: [temp_string := (temp_string,' ')] .
		stream nextPutAll:temp_string . 
		stream nextPutAll: ' ---------------------------------
' .
		(1 to:10) do: [ :a |
			stream nextPutAll: '-----------------------------------' .
			stream nextPutAll: '-----------------------------------
|' .
			(1 to:10) do: [ :b |
				temp_string := ((grid getLynxesAtRow:a col:b) asString) .
				[(temp_string size) < 4] whileTrue: [temp_string := (' ',temp_string)] .
				stream nextPutAll: (temp_string,' | ') . 
			] .
			stream nextPutAll: '
|' .
			(1 to:10) do: [ :b |
				temp_string := ((grid getRabbitsAtRow:a col:b) asString) . 
				[(temp_string size) < 4] whileTrue: [temp_string := (' ',temp_string)] .
				stream nextPutAll: (temp_string,' | ') . 
			] .
			stream nextPutAll: '
' .
		] .
		stream nextPutAll: '-----------------------------------' .
		stream nextPutAll: '-----------------------------------
' .
	]
	status [
		self printNl .
	]
]

Simulation extend [
	step [
		| current_animal |
		"Set all animals active."
		grid makeAllActive .
		month := (month + 1) .
		(1 to:10) do: [ :r |
			(1 to:10) do: [ :c |
				current_animal := (grid getActiveAtRow:r Col:c) .
				[(current_animal isNil) = false] whileTrue: [
					grid remove:current_animal row:r col:c .
					current_animal move .
					grid place:current_animal row: (current_animal getRow) col: (current_animal getCol) .
					current_animal setGrid: grid .
					current_animal act .
					current_animal deactivate .
					current_animal := (grid getActiveAtRow:r Col:c) .
				].
			] .
		] .
	]
]



