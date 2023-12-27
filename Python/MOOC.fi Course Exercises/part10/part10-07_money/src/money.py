# TEE RATKAISUSI TÄHÄN:
class Money:
    def __init__(self, euros: int, cents: int):
        self._euros = euros
        self._cents = cents
    def __str__(self):
        if self._cents < 10 :
            return f"{self._euros}.0{self._cents} eur"
        else:
            return f"{self._euros}.{self._cents} eur"


    def __eq__(self, another):
        return self._euros == another._euros and self._cents == another._cents

    def __ne__(self, another):
        return (self._euros + self._cents) != (another._euros + another._cents)

    def __lt__(self, another):
        return (self._euros + self._cents) < (another._euros + another._cents)

    
    def __gt__(self, another):
        return (self._euros + self._cents) > (another._euros + another._cents)

    def __add__(self, another):
        self._euros += another._euros
        self._cents += another._cents
        if self._cents >= 100:
            self._cents -= 100
            self._euros += 1
        new = Money(self._euros, self._cents)
        return new

    def __sub__(self, another):
        self._euros -= another._euros
        self._cents -= another._cents
        if self._cents < 0:
            self._cents += 100
            self._euros -= 1
        if self._euros < 0:
            raise ValueError(("a negative result is not allowed"))
        else: 
            new = Money(self._euros, self._cents)
            return new
