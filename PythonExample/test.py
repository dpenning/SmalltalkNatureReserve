import random

class Animal:
	def __init__(self,uid=0,row=0,col=0,direction=None,active=False):
		self._id = uid
		self._row = row
		self._col = col
		self._active = active
		if direction == None:
			self._dir = ["Left","Right","Up","Down"][random.randint(0,3)]
		else:
			self._dir = direction
	def getID(self):
		return self._id
	def getRow(self):
		return self._row
	def getCol(self):
		return self._col
	def setRow(self,row):
		self._row = row
	def setCol(self,col):
		self._col = col
	def getDirection(self):
		return self._dir
	def setDirection(self,direction):
		self._dir = direction
	def move(self):
		if self._dir == "Up":
			if self.getRow() == 0:
				self.setRow(9)
				return
			self.setRow(self.getRow()-1)
			return
		if self._dir == "Down":
			if self.getRow() == 9:
				self.setRow(0)
				return
			self.setRow(self.getRow()+1)
			return
		if self._dir == "Left":
			if self.getCol() == 0:
				self.setCol(9)
				return
			self.setCol(self.getCol()-1)
			return
		if self._dir == "Right":
			if self.getCol() == 9:
				self.setCol(0)
				return
			self.setCol(self.getCol()+1)
			return
	def getActive(self):
		return self._active
	def setActive(self):
		self._active = True
class Lynx(Animal):
	def act(self,grid):
		self.move()
		self.setDirection(["Left","Right","Up","Down"][random.randint(0,3)])
		rabbits = grid.getRabbitsAtRowCol(self._row,self._col)
		if rabbits > 0:
			grid.removeRowCol(Rabbit,self._row,self._col)
			grid.placeRowCol(Lynx,self._row,self._col)
		else:
			grid.removeRowCol(Lynx,self._row,self._col,uid=self._id)
		self._active = False
class Rabbit(Animal):
	def act(self,grid):
		self.move()
		self.setDirection(["Left","Right","Up","Down"][random.randint(0,3)])
		rabbits = grid.getRabbitsAtRowCol(self._row,self._col)
		if rabbits > 1:
			grid.placeRowCol(Rabbit,self._row,self._col)
			grid.placeRowCol(Rabbit,self._row,self._col)
		self._active = False
class Grid:
	def __init__(self):
		self._animals = []
		self._uid_counter = 1
	def getLynxesAtRowCol(self,row,col):
		return len([x for x in self._animals if (x.getRow() == row and x.getCol() == col and type(x) == Lynx)])
	def getRabbitsAtRowCol(self,row,col):
		return len([x for x in self._animals if (x.getRow() == row and x.getCol() == col and type(x) == Rabbit)])
	def placeRowCol(self,animal,row,col):
		new_animal = None
		if animal == Rabbit:
			new_animal = Rabbit(uid=self._uid_counter,row=row,col=col)
			self._uid_counter += 1
		elif animal == Lynx:
			new_animal = Lynx(uid=self._uid_counter,row=row,col=col)
			self._uid_counter += 1
		self._animals.append(new_animal)
	def removeRowCol(self,animal,row,col,uid=None):
		if uid != None:
			for a in self._animals:
				if a == animal and a.getRow == row and a.getCol == col and a.getID() == uid:
					self._animals.remove(self._animals.index(a))
					return
		for a in self._animals:
			if a == animal and a.getRow == row and a.getCol == col:
				self._animals.remove(self._animals.index(a))
				return
	def setAllActive(self):
		for a in self._animals:
			a.setActive()
	def anActiveAnimal(self):
		for a in self._animals:
			if a.getActive():
				return True
		return False
	def getActiveAnimal(self):
		for a in self._animals:
			if a.getActive():
				return a
		return None
	def printGrid(self):
		for a in range(10):
			line_1 = " ---"*10
			line_2 = ""
			line_3 = ""
			for b in range(10):
				line_2 += "|"
				rabbits = self.getRabbitsAtRowCol(a,b)
				if len(str(rabbits)) == 1:
					line_2 += " " +str(rabbits) + " "
				if len(str(rabbits)) == 2:
					line_2 += " " +str(rabbits)
				if len(str(rabbits)) == 3:
					line_2 += str(rabbits)
				line_3 += "|"
				lynxes = self.getLynxesAtRowCol(a,b)
				if len(str(lynxes)) == 1:
					line_3 += " " +str(lynxes) + " "
				if len(str(lynxes)) == 2:
					line_3 += " " +str(lynxes)
				if len(str(lynxes)) == 3:
					line_3 += str(lynxes)
			print (line_1)
			print (line_2 + "|")
			print (line_3 + "|")
		print (" ---"*10)




if __name__ == "__main__":
	g = Grid()
	for a in range(10):
		g.placeRowCol(Rabbit,random.randint(0,9),random.randint(0,9))
	for a in range(30):
		g.placeRowCol(Lynx,random.randint(0,9),random.randint(0,9))
	month = 0
	while month < 10:
		g.setAllActive()
		month += 1
		while g.anActiveAnimal():
			an = g.getActiveAnimal()
			an.act(g)
		print ("---" + str(month) + "---")
		g.printGrid()
		