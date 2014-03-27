(FileStream open: 'classes.st' mode: 'r') fileIn . !
	| the_sim |
		the_sim := Simulation new .
		the_sim setup . 
		the_sim printNl. 
!