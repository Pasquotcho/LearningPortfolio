class WeatherStation:

    def __init__(self, name:str):
        self.__name = name
        self.__liste = []

    def add_observation(self, observation: str):
        self.__liste.append(observation)

    def latest_observation(self):
        if len(self.__liste) > 0: 
            return self.__liste[-1]
        else:
            return "0"

    def number_of_observations(self):
        return len(self.__liste)
    
    def __str__(self):
        return f"{self.__name}, {len(self.__liste)} observations"

