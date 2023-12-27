# Write your solution here:
import time
class Stopwatch:
    def __init__(self):
        self.seconds = 0
        self.minutes = 0

    def tick(self):
        if self.seconds != 59:
            self.seconds += 1
        elif self.seconds == 59:
            self.seconds = 0
            if self.minutes != 59:
                self.minutes += 1
            else:
                self.minutes = 0

    def __str__(self):
        return f"{self.minutes:02}:{self.seconds:02}"
        


if __name__ == "__main__":
    watch = Stopwatch()

    for i in range(3600):
        print(watch)
        watch.tick()
