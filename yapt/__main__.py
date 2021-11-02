from yapt.calculator import Calculator
from yapt.calculator import Number


def multiplication_table(operand: Number) -> None:
    '''Calculate and outputs a multiplication table of a given value.

    Args:
        operand (Number): The multiplication number
    '''
    print(f'Times table of {operand}:\n')

    for idx in range(1, 11):
        calc = Calculator(operand)
        result = calc.times(idx).equals()

        print(f'{idx} x {operand} = {result}')


if __name__ == '__main__':
    multiplication_table(7)
