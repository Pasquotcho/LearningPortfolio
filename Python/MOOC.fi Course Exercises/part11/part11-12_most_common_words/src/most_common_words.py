# WRITE YOUR SOLUTION HERE:
def most_common_words(filename: str, lower_limit: int):
    all_words = []

    with open(filename, "r") as file:
        for line in file:
            line.replace("\n", "")
            words = line.split()
            for i in range(len(words)):
                words[i] = words[i].replace(".", "").strip()
                words[i] = words[i].replace(",", "").strip()
                words[i] = words[i].replace("-", "").strip()
                
            all_words.extend(words)
        counted_words = {word: all_words.count(word) for word in all_words}
        return{word: count for word, count in counted_words.items() if count >= lower_limit}
        return{word: all_words.count(word) for word in all_words if all_words.count(word) >= lower_limit}
    


