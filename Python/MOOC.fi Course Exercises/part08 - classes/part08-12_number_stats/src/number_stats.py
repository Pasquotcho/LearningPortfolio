# Write your solution here!
class  NumberStats:
    def __init__(self):
        self.numbers = 0
        self.numberlist = []

    def add_number(self, number:int):
        self.numberlist.append(number)
        

    def count_numbers(self):
        return len(self.numberlist)

    def get_sum(self):
        if len(self.numberlist) == 0:
            return 0
        else:
            return sum(self.numberlist)


    def average(self):
        if len(self.numberlist) == 0:
            return 0
        else:
            average = sum(self.numberlist) / len(self.numberlist)
            return average


inputclass = NumberStats()
inputclassodd = NumberStats()
inputclasseven = NumberStats()


while True:
    userinput = int(input("Type a number: "))

    if userinput == -1:
        print(f"Sum of numbers: {inputclass.get_sum()}")
        print(f"Mean of numbers: {inputclass.average()}")
        print(f"Sum of even numbers: {inputclasseven.get_sum()}")
        print(f"Sum of odd numbers: {inputclassodd.get_sum()}")


        break
    else:
        inputclass.add_number(userinput)
        if userinput % 2 == 0:
            inputclasseven.add_number(userinput)
        elif userinput % 2 != 0:
            inputclassodd.add_number(userinput)
