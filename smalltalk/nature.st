Object subclass: #Animal .
Animal instanceVariableNames: 'row column direction ID' .
Animal class instanceVariableNames: 'currentID' .
Animal comment: 'This is an animal' .

Animal class extend [
	new [
		| temp |
		currentID isNil ifTrue: [currentID := 1].
		temp := super new.
		tempID := newID.
		temp init: tempID.
		^temp
	]
	newID [
		currentID := currentID + 1.
		^currentID
	]
]

Animal extend [
	init: newID [
		row := -1.
		column := -1.
		direction := -1.
		ID := newID.
	]
	getID [ ^ID ]
	getRow [ ^row ]
	getCol [ ^column ]
	getDirection [ ^direction ]
	setDirection [ direction := (1 to: 4) atRandom. ]
	printOn: stream [
		super printOn: stream.
		stream nextPutAll: '(ID)' .
		ID printOn: stream
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
Grid instanceVariablesNames: 'gridArray' .

Grid class extend [
	new [
	]
]