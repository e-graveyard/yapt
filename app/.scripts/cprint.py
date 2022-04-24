# standard
import sys

# 3rd-party
from colorama import Style
from colorama import Fore
from colorama import init
init(autoreset=True)


def main():
    phrase = '~ ' + ' '.join(sys.argv[1:])
    print('\n')
    print(Fore.BLUE + phrase)
    print(Style.BRIGHT + Fore.BLUE + len(phrase) * '.')


if __name__ == '__main__':
    main()
