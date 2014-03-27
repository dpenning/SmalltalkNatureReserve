Object subclass: #Animal .
Animal instanceVariableNames: 'active row column direction ID' .
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
		active := false.
		row := -1.
		column := -1.
		direction := -1.
		ID := Animal getCount.
	]
	getActive [ ^active ]
	activate [ active := true ]
	deactivate [ active := false ]
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
		^((gridArray at:r) at:c) remove: animal ifAbsent: [] .
	]
	debugRow:r Col:c [
		^((gridArray at:r) at:c) 
	]
	makeAllActive [
		(1 to: 10) do: [ :a | 
			(1 to: 10) do: [ :b | 
				((gridArray at:a) at:b) do: [ :c | c activate ].
			] .
		] .
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
		|temp_string|
		(1 to:10) do: [ :a |
			stream nextPutAll: '-----------------------------------' .
			stream nextPutAll: '-----------------------------------
|' .
			(1 to:10) do: [ :b |
				temp_string := ((grid getLynxesAtRow:a Col:b) asString) .
				[(temp_string size) < 4] whileTrue: [temp_string := (' ',temp_string)] .
				stream nextPutAll: (temp_string,' | ') . 
			] .
			stream nextPutAll: '
|' .
			(1 to:10) do: [ :b |
				temp_string := ((grid getRabbitsAtRow:a Col:b) asString) . 
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
]

Simulation extend [
	step [
		"set all animals active"
		gridArray makeAllActive .
		((1 to:10) shuffled) do: [ :r |
			((1 to:10) shuffled) do: [ :c |
				"this is the actual thing we need to do"
				"perform an action on all "
			] .
		] .
	]
]



