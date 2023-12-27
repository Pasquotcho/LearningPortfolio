class Series:
    def __init__(self, title:str, seasons:int, genres:list):
        self.title = title
        self.seasons = seasons
        self.genres = genres
        self.ratinglist = []
        
        

    def __str__(self):
        
        if len(self.ratinglist) != 0:
            return f"{self.title} ({self.seasons} seasons)\ngenres: {", ".join(self.genres)}\n{len(self.ratinglist)} ratings, average {self.raiting:.1f} points"
        else:
            return f"{self.title} ({self.seasons} seasons)\ngenres: {", ".join(self.genres)}\nno ratings"


    def rate(self, rating: int):
        if rating in range(0,6):
            self.ratinglist.append(rating)
            self.raiting = sum(self.ratinglist) / len(self.ratinglist)
        else:
            raise ValueError("So nicht")




    


def minimum_grade(rating: float, series_list: list):
    minimumlist = []
    for serie in series_list:
        if serie.raiting >= rating:
            minimumlist.append(serie)
    return minimumlist

def includes_genre(genre: str, series_list: list):
    genrelist = []
    for serie in series_list:
        if genre in serie.genres:
            genrelist.append(serie)
    return genrelist



if __name__ == "__main__":

    s1 = Series("Dexter", 8, ["Crime", "Drama", "Mystery", "Thriller"])
    s1.rate(5)

    s2 = Series("South Park", 24, ["Animation", "Comedy"])
    s2.rate(3)

    s3 = Series("Friends", 10, ["Romance", "Comedy"])
    s3.rate(2)

    s3 = Series("Aha", 10, ["Romance", "Comedy"])
    s3.rate(5)


    series_list = [s1, s2, s3]
    print("a minimum grade of 4.5:")
    for series in minimum_grade(4.5, series_list):
        print(series.title)

    print("genre Comedy:")
    for series in includes_genre("Comedy", series_list):
        print(series.title)
