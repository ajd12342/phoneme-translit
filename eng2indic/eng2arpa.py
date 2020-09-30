import argparse
import sys

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--arpa', required=True)
    args = parser.parse_args()

    with open(args.arpa, 'r') as f:
        arpafile =  [_.strip().split() for _ in f.readlines()]

    mapping = dict([(_[0], ' '.join(_[1:])) for _ in arpafile])

    for line in sys.stdin:
        utt_id = line.split()[0]
        line_words = line.split()[1:]

        arpa = ' <space> '.join([mapping[_] for _ in line_words])

        outp = utt_id + ' ' + arpa
        print(outp)