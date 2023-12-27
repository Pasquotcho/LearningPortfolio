# WRITE YOUR SOLUTION HERE:

class Present:
    def __init__(self, name : str , weight : int ):
        self.name = name
        self.weight = weight

    def __str__(self):
        return (f"{self.name} ({self.weight} kg)")




class Box:
    def __init__(self):
        self.weight = 0
        self.boxes = []

    def add_present(self, present: Present):
        self.weight += present.weight

    def total_weight(self):
        return self.weight


