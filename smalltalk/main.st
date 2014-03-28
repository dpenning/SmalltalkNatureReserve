(FileStream open: 'classes.st' mode: 'r') fileIn . !
	"Main program to run a basic simulation for 5 turns."
	| the_sim |
		the_sim := Simulation new .
		the_sim setup .
		1 to: 5 do: [:a |
		the_sim step . 
		the_sim status. 
		]
!
