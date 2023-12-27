# DO NOT CHANGE THE CODE OF THE CLASS
# ShoppingList. Write yous solution under it!
class ShoppingList:
    def __init__(self):
        self.products = []

    def number_of_items(self):
        return len(self.products)

    def add(self, product: str, number: int):
        self.products.append((product, number))

    def item(self, n: int):
        return self.products[n - 1][0]

    def amount(self, n: int):
        return self.products[n - 1][1]

# -------------------------
# Write your solution here:
# -------------------------


def total_units(my_list: ShoppingList):
    value = 0
    for item in my_list.products:
        value += item[1]

    return value

if __name__ == "__main__":
    shopping_list = ShoppingList()
    shopping_list.add("Chips", 2)
    shopping_list.add("Banane", 3)
    shopping_list.add("Apfel", 1)
    shopping_list.add("Brot", 2)








