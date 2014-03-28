(FileStream open: 'classes.st' mode: 'r') fileIn . !
	| the_sim |
		the_sim := Simulation new .
		the_sim setup . 
		the_sim status. 
		the_sim step . 
		the_sim status. 
!