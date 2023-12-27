# Write your solution here:
class Book:

    def __init__(self, name: str, author: str, genre: str, year: int):
        self.name = name
        self.author = author
        self.genre = genre 
        self.year = year 

if __name__ == "__main__":
    harrydapothead = Book("HarryPothead", "RowlingStone", "Magicka",2020)

    print(harrydapothead.author)