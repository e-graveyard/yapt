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


def itself(value: Number) -> Number:
    return Calculator(value).plus(value).minus(value).times(value).divided(value).equals()


def main() -> None:
    my_value = 7

    multiplication_table(my_value)

    if itself(my_value) != my_value:
        raise RuntimeError('something went wrong here!!')


if __name__ == '__main__':
    main()
