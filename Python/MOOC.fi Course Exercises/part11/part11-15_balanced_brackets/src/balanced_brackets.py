
def balanced_brackets(my_string: str):
    allowed = ["(", ")", "[", "]"]
    filtered = [ch for ch in my_string if ch in allowed]
    filtered = "".join(filtered)
    print(filtered)
    if len(filtered) == 0:
        return True
    if len(filtered) == 1:
        return False



    if not ((filtered[0] == '(' and filtered[-1] == ')' or filtered[0] == "["  and filtered[-1] == "]")):
        return False

    # remove first and last character
    return balanced_brackets(filtered[1:-1])
