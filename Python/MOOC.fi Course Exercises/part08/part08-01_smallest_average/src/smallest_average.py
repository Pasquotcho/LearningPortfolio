

def average(a:dict):
    er = (a["result1"] + a["result2"] + a["result3"]) / 3
    return er

def smallest_average(person1: dict, person2: dict, person3: dict):
    smallest = person1

    if average(person2) < average(smallest):
        smallest = person2
    if average(person3) < average(smallest):
        smallest = person3
    return smallest










