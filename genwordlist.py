import sys
import itertools

if __name__ == "__main__":
    words = sorted(set(itertools.chain(*[_.strip().split()[1:] for _ in sys.stdin.readlines()])))
    for word in words:
        print(word)