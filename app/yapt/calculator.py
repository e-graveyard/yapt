from typing import TypeVar
from typing import Union

Number = Union[int, float]
'''Base type accepted by the __Calculator__ operators.'''

CalcSelf = TypeVar('CalcSelf', bound='Calculator')
'''Calculator __self__ reference.'''


class Calculator:
    '''Calculator with basic mathematical operations and chainable methods.

    Example:
        ```python
        >>> res = Calculator(1) \  # start value    ; value = 1
                    .plus(2)    \  # adds 2         ; value = 3
                    .times(4)   \  # multiples by 4 ; value = 12
                    .divided(2) \  # divides by 2   ; value = 6
                    .equals()

        >>> print(res)
        6
        ```

    Warning:
        Due to the fact that Python relies on whitespace to define indentation,
        the methods needs to be chained either:

        1. On the same line
           ```python
           Calculator(999).plus(1).plus(2).plus(3)
           ```

        1. By using a backslack to indicate a "continuation" (like in the example above)
           ```python
           Calculator(999) \\
             .plus(1) \\
             .plus(2) \\
             .plus(3)
           ```

        1. By scoping the code block inside parentheses
           ```python
           (
             Calculator(999)
               .plus(1)
               .plus(2)
               .plus(3)
           )
           ```
    '''

    def __init__(self, operand: Number) -> None:
        '''
        Args:
            operand: The initial value set on the result attribute
                (the _accumulator_).
        '''

        self.result: Number = operand
        '''The final result _accumulator_. Each operation is performed against this value.'''

    def plus(self: CalcSelf, value: Number) -> CalcSelf:
        '''Adds a value to the current result.

        Args:
            value: The number value to be added.

        Returns:
            Reference to the class itself instance.
        '''
        self.result += value
        return self

    def minus(self: CalcSelf, value: Number) -> CalcSelf:
        '''Subtracts a value to the current result.

        Args:
            value: The number value to be subtracted.

        Returns:
            Reference to the class itself instance.
        '''
        self.result -= value
        return self

    def divided(self: CalcSelf, value: Number) -> CalcSelf:
        '''Divides a value to the current result.

        Args:
            value: The number to divide the result.

        Returns:
            Reference to the class itself instance.
        '''
        self.result /= value
        return self

    def times(self: CalcSelf, value: Number) -> CalcSelf:
        '''Multiplies a value to the current result.

        Args:
            value: The number to multiply the result.

        Returns:
            Reference to the class itself instance.
        '''
        self.result *= value
        return self

    def equals(self) -> Number:
        '''Finishes the calculation and returns the final result.

        Returns:
            The calculation result.
        '''
        return self.result
