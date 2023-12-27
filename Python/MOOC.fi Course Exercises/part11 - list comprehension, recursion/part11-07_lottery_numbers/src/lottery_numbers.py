class LotteryNumbers:
    def __init__(self, week:int, list:list):
        self.week = week
        self.list = list
    def number_of_hits(self, numbers: list):
        return len([number for number in self.list if number in numbers])
    
    def hits_in_place(self, numbers:list):
        return[number if number in self.list else -1 for number in numbers]

