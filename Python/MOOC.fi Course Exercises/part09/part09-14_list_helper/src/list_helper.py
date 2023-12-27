class ListHelper:

    @classmethod
    def greatest_frequency(cls, liste: list):
        most_commons = {}
        for item in liste:
            if item in most_commons:
                most_commons[item] += 1
            else:
                most_commons[item] = 1

        max_key = max(most_commons, key=most_commons.get)
        return max_key

    
    @classmethod
    def doubles(cls, liste: list):
        most_commons = {}
        einzigartig = []
        for item in liste:
            if item in most_commons:
                most_commons[item] += 1
            else:
                most_commons[item] = 1

        for key, value in most_commons.items():
            if value > 1:
                einzigartig.append(key)
        return len(einzigartig)
            

        