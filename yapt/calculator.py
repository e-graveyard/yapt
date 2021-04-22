from typing import Union

Number = Union[int, float]


class Calculator:
    def __init__(self, operand: Number) -> None:
        self.result: Number = operand

    def plus(self, value: Number):
        self.result += value
        return self

    def minus(self, value: Number):
        self.result -= value
        return self

    def divided(self, value: Number):
        self.result /= value
        return self

    def times(self, value: Number):
        self.result *= value
        return self

    def equals(self) -> Number:
        return self.result
