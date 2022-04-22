from yapt.calculator import Calculator


def test_sum_two_values():
    result = Calculator(1).plus(1).equals()
    assert result == 2


def test_subtract_two_values():
    result = Calculator(7).minus(1).equals()
    assert result == 6


def test_divide_one_by_another():
    result = Calculator(9).divided(3).equals()
    assert result == 3


def test_multiply_one_by_another():
    result = Calculator(4).times(4).equals()
    assert result == 16


def test_complex_operation():
    result = Calculator(10).plus(1).times(2).minus(2).divided(4).equals()
    assert result == 5
