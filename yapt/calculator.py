from typing import Union

Number = Union[int, float]


class Calculator:
    '''Calculator with basic operations.

    Usage example:

        calc = Calculator(1)
        result = calc.plus(2).times(4).divided(2)
        print(result)  # 6
    '''
    def __init__(self, operand: Number) -> None:
        self.result: Number = operand

    def plus(self, value: Number):
        '''Adds a value to the current result.

        Args:
            value (Number): The number value to be added

        Returns:
            self: The class itself object
        '''
        self.result += value
        return self

    def minus(self, value: Number):
        '''Subtracts a value to the current result.

        Args:
            value (Number): The number value to be subtracted

        Returns:
            self: The class itself object
        '''
        self.result -= value
        return self

    def divided(self, value: Number):
        '''Divides a value to the current result.

        Args:
            value (Number): The number to divide the result

        Returns:
            self: The class itself object
        '''
        self.result /= value
        return self

    def times(self, value: Number):
        '''Multiplies a value to the current result.

        Args:
            value (Number): The number to multiply the result

        Returns:
            self: The class itself object
        '''
        self.result *= value
        return self

    def equals(self) -> Number:
        '''Finishes the calculation and returns the final result.

        Returns:
            Number: The calculation result
        '''
        return self.result
