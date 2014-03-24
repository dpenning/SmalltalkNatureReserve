"simple test case"

	Object subclass: #Animal .
	Animal instanceVariableNames: 'id row col dir active' .
	Animal class instanceVariableNames '' . 
	Animal comment: 'I represent the base class for Lynxes/Rabbits' .

	Animal class extend [
		new [
			| r |
			<category: 'instance creation'>
			r := super new .
			r init . 
			^r .
		]
	]

	Animal extend [
		initWithID:uid Row:r Col:c Dir:d [
			active := false .
			id := uid . 
			row := r . 
			col := c . 
			dir := d .
		]
		getID [
			^ id .
		]
		getRow [
			^ row .
		]
		getCol [
			^ col . 
		]
		getDirection [
			^ dir . 
		]
		setRow:r [
			row := r
		]
		setCol:c [
			col := c
		]
		setDirection:direction [
			dir := direction
		]
		setActive:active [
		]

	]