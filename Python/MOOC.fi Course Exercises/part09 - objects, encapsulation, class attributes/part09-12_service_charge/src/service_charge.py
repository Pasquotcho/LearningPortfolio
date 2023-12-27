# WRITE YOUR SOLUTION HERE:


class BankAccount:

    def __init__(self, name: str, account_number: str, balance: float):
        self.__name = name
        self.__account_number = account_number
        self.__balance = balance

    def deposit(self, amount:float):
        self.__balance += amount
        self.__service_charge(self.__balance)

    def withdraw(self, amount: float):
        self.__balance -= amount
        self.__service_charge(self.__balance)

    @property
    def balance(self):
        return self.__balance


    def __service_charge(self, amount):
        charge = amount / 100 * 1
        self.__balance -= charge

