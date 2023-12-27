# WRITE YOUR SOLUTION HERE:
def filter_forbidden(string: str, forbidden: str):
    return "".join([ch for ch in string if ch not in forbidden])
