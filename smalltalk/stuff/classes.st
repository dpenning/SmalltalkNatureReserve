Object subclass: #Animal .
Animal instanceVariableNames: 'row column direction ID' .
Animal class instanceVariableNames: 'currentID' .
Animal comment: 'This is an animal' .

Animal class extend [
	new [
		| temp |
		temp := super new . 
		temp init. 
		^temp
	]
	getCount [
		currentID ifNil: [currentID := 0].
		currentID := (currentID + 1). 
		^currentID
	]
]
Animal extend [
	init [
		row := -1.
		column := -1.
		direction := -1.
		ID := Animal getCount.
	]
	setRow:r [ row := r ]
	setCol:c [ column := c ]
	getID [ ^ID ]
	getRow [ ^row ]
	getCol [ ^column ]
	getDirection [ ^direction ]
	setDirection [ direction := (1 to: 4) atRandom. ]
	printOn: stream [
		super printOn: stream.
		stream nextPutAll: '(' .
		ID printOn: stream.
		stream nextPutAll: ')' .
	]
]

Animal subclass: #Rabbit.

Rabbit extend [
	act []
]

Animal subclass: #Lynx.

Lynx extend[
	act []
]






Object subclass: #Grid .
Grid instanceVariableNames: 'gridArray' .
Grid class instanceVariableNames: '' .
Grid comment: 'a Grid' .

Grid class extend [
	new [
		| temp |
		temp := super new . 
		temp init. 
		^temp
	]
]
Grid extend [
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
	getLynxesAtRow:r Col:c [
		^((((gridArray at:r) at:c) select: [:a | a class = Lynx]) size)
	]
	getRabbitsAtRow:r Col:c [
		^((((gridArray at:r) at:c) select: [:a | a class = Rabbit]) size)
	]
	place:animal row:r col:c [
		"puts an animal at r,c"
		animal setRow:r .
		animal setCol:c .
		((gridArray at:r) at:c) addLast:animal .
	]
	remove:animal row:r col:c [
		"First get the location of the animal in the gridArray"
		((gridArray at:r) at:c) remove: animal ifAbsent: [] .
	]
	debugRow:r Col:c [
		^((gridArray at:r) at:c) 
	]
	makeAllActive [
	]
]





Object subclass: #Simulation .
Simulation instanceVariableNames: 'grid' .
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
		grid := Grid new .
	]
	setup [
		(1 to:50) do: [ :a |
			| x y new_rabbit |
				x := (1 to:10) atRandom .
				y := (1 to:10) atRandom .
				new_rabbit := Rabbit new .
				grid place:new_rabbit row:a col:b .
		].
		(1 to:10) do: [ :a |
			| x y new_lynx |
				x := (1 to:10) atRandom .
				y := (1 to:10) atRandom .
				new_lynx := Lynx new .
				grid place:new_lynx row:a col:b .
		].
	]
]




