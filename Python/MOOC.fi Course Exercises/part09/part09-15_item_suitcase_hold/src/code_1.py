# Write your solution here:
class Item:
    def __init__(self, name:str, weight:int):
        self.__name = name
        self.__weight = weight


    def __str__(self):
        return(f"{self.__name} ({self.__weight} kg)")


    def weight(self):
            return self.__weight


    def name(self):
            return self.__name

class Suitcase:
    def __init__(self, max_weight:int):
        self.now_weight = 0
        self.max_weight = max_weight
        self.item_list = []

    def add_item(self, item: Item):
        if self.now_weight + item.weight() <= self.max_weight:
            self.now_weight += item.weight()
            self.item_list.append(item)
        else:
            return

    def __str__(self):
        if len(self.item_list) == 1:
            return f"{len(self.item_list)} item ({self.now_weight} kg)"        
        else:
            return f"{len(self.item_list)} items ({self.now_weight} kg)"

    def print_items(self):
        for item in self.item_list:
            print(str(item))

    def weight(self):
        return self.now_weight

    def heaviest_item(self):
        heaviest = 0
        name = None
        for item in self.item_list:
            if item.weight() > heaviest:
                heaviest = item.weight()
                name = item
        return name


class CargoHold:
    def __init__(self, max_weight:int):
        self.weight = 0 
        self.max_weight = max_weight
        self.case_list = []


    def add_suitcase(self, item: Suitcase):
        if self.weight + item.now_weight < self.max_weight:
            self.case_list.append(item)
            self.weight += item.now_weight
            
    def __str__(self):
        if len(self.case_list) == 1:
            return f"{len(self.case_list)} suitcase, space for {self.max_weight - self.weight} kg"
        else:
            return f"{len(self.case_list)} suitcases, space for {self.max_weight - self.weight} kg"


    def print_items(self):
        for item in self.case_list:
            item.print_items()

