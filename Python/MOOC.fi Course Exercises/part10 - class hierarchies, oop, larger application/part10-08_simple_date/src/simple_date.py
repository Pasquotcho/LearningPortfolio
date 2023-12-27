class SimpleDate:
    def __init__(self, day:int, month:int, year:int):
        self.day = day
        self.month = month
        self.year = year

    def __str__(self):
        return f"{self.day}.{self.month}.{self.year}"
    
    def __add__(self, zahl:int):
        new_date = SimpleDate(self.day, self.month, self.year)
        new_date.day += zahl
        while new_date.day > 30:
            new_date.month += 1
            new_date.day -= 30
        while new_date.month > 12:
            new_date.year += 1
            new_date.month -= 12
        
        return new_date

    def __eq__(self, other):
        return self.year == other.year and self.month == other.month and self.day == other.day
    
    def __ne__(self, other):
        return self.year != other.year or self.month != other.month or self.day != other.day

    def __lt__(self, other):
        if self.year < other.year:
            return True
        elif self.year > other.year:
            return False
        if self.month < other.month:
            return True
        elif self.month > other.month:
            return False
        if self.day < other.day:
            return True
        else:
            return False
    def __gt__(self, other):
        if self.year < other.year:
            return False
        if self.month < other.month:
            return False
        if self.day < other.day:
            return False
        else:
            return True

    def __sub__(self, other):
        days = (self.day + (self.month * 30) + (self.year * 360))
        other_days = (other.day + (other.month * 30) + (other.year * 360))
        return abs(days - other_days)
    