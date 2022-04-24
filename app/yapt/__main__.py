'''__YAPT top-level environment.__

The program starts here. In this file we have the `main` function and the
execution scope conditional, aka:

```python
if __name__ == '__main__':
    main()
```

Inside the docstrings we can use markdown and other [MkDocs Material][material]-specific features,
such as [admonitions][admonitions], [content tabs][ctabs], [diagrams][diagrams] and whatnot.

???+ info "I am an admonition"
    Already expanded, so everyone can see my content.

??? danger "Expand me"
    Glad you did. How fancy this flowchart, isn't?

    ```mermaid
    graph LR
      A[Start] --> B{Error?};
      B -->|Yes| C[Hmm...];
      C --> D[Debug];
      D --> B;
      B ---->|No| E[Yay!];
    ```

[material]: https://squidfunk.github.io/mkdocs-material
[admonitions]: https://squidfunk.github.io/mkdocs-material/reference/admonitions/#admonitions
[ctabs]: https://squidfunk.github.io/mkdocs-material/reference/content-tabs/#usage
[diagrams]: https://squidfunk.github.io/mkdocs-material/reference/diagrams/#usage
'''


from yapt.calculator import Calculator
from yapt.calculator import Number


def multiplication_table(operand: Number) -> None:
    '''Calculates and outputs a multiplication table of a given value.

    Example:
        ```python
        >>> multiplication_table(7)
        Times table of 7:
          | 1 x 7 = 7
          | 2 x 7 = 14
          | 3 x 7 = 21
          | 4 x 7 = 28
          | 5 x 7 = 35
          | 6 x 7 = 42
          | 7 x 7 = 49
          | 8 x 7 = 54
          | 9 x 7 = 63
          | 10 x 7 = 70
        ```

    Args:
        operand: The multiplication number.
    '''
    print(f'Times table of {operand}:')

    for idx in range(1, 11):
        calc = Calculator(operand)
        result = calc.times(idx).equals()

        print(f'  | {idx} x {operand} = {result}')


def itself(value: Number) -> Number:
    '''Execute the calculator's operations using the same operand value.

    Operations are executed in the following order: _addition_, _subtraction_,
    _multiplication_, _division_. Because of this order, one operation nulls
    the preceding and the returned value will always be equals to the received
    value.

    Example:
        ```python
        >>> itself(2)  # { [ (2 + 2) - 2 ] * 2 } / 2
        2
        ```

    Args:
        value: Initial value and operand used in all operations.

    Returns:
        The operations result.
    '''
    return Calculator(value).plus(value).minus(value).times(value).divided(value).equals()


def main() -> None:
    '''Main function (entrypoint) of the application.

    Raises:
        RuntimeError: if for some reason the `itself` function fails to return
            the sent value.
    '''
    my_value = 7

    multiplication_table(my_value)

    if itself(my_value) != my_value:
        raise RuntimeError('something went wrong here!!')


if __name__ == '__main__':
    main()
