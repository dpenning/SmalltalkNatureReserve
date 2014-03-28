(FileStream open: 'classes.st' mode: 'r') fileIn . !
" test routine for ID's "
|a b c d e f|
	a := Animal new .
	b := Rabbit new .
	c := Lynx new .
	d := Animal new .
	e := Rabbit new .
	f := Lynx new .
	((a getID) = 1) ifFalse: ['IDs did not work.' printNl]. 
	((b getID) = 2) ifFalse: ['IDs did not work.' printNl]. 
	((c getID) = 3) ifFalse: ['IDs did not work.' printNl]. 
	((d getID) = 4) ifFalse: ['IDs did not work.' printNl]. 
	((e getID) = 5) ifFalse: ['IDs did not work.' printNl]. 
	((f getID) = 6) ifFalse: ['IDs did not work.' printNl]. 
!