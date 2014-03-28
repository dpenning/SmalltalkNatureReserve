#Use gst -g to remove the random garbage collection messages
GOAL = prog3
TDIR = tests/
SRC = classes.st
FLAGS = -g

default: $(GOAL)

$(GOAL): $(SRC) 
	gst $(FLAGS) main.st

test1:
	gst $(FLAGS) $(TDIR)test_1.st

test2:
	gst $(FLAGS) $(TDIR)test_2.st

test3:
	gst $(FLAGS) $(TDIR)test_3.st

test4:
	gst $(FLAGS) $(TDIR)test_4.st
