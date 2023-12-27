
class Clock:
    def __init__(self, hours: int, minutes: int, seconds: int):
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours


    def tick(self):
        if self.seconds != 59:
            self.seconds += 1
        elif self.seconds == 59:
            self.seconds = 0
            if self.minutes != 59:
                self.minutes += 1
            else:
                self.minutes = 0
                if self.hours != 23:
                    self.hours += 1
                else:
                    self.hours = 0


    def __str__(self):
        return f"{self.hours:02}:{self.minutes:02}:{self.seconds:02}"

    def set(self, hours:int = 0, minutes:int = 0, seconds:int = 0):
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        
        


if __name__ == "__main__":
    watch = Clock(23, 59, 59)


