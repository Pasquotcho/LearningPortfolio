# WRITE YOUR SOLUTION HERE:
class Car:
    def __init__(self):
        self.__tank = 0
        self.__odometer = 0
    def __str__(self):
        return f"Car: odometer reading {self.__odometer} km, petrol remaining {self.__tank} litres"

    def fill_up(self):
        self.__tank = 60

    def drive(self, km:int):
        for l in range(km):
            if self.__tank == 0:
                break
            self.__tank -= 1
            self.__odometer += 1

        

