(FileStream open: 'classes.st' mode: 'r') fileIn . !
| simulation_1 simulation_2 |
	simulation_1 := Simulation new .
	simulation_2 := Simulation new .
	simulation_1 setup .
	simulation_2 setup .
	simulation_1 printNl .
	simulation_2 printNl .
	simulation_1 step . 
	simulation_2 step . 
	simulation_1 printNl .
	simulation_2 printNl .