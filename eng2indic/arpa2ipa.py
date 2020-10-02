import argparse
import sys
import importlib

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--lang', required=True, choices=['hin'])
    parser.add_argument('--version', required=True, choices=['v1', 'v1a', 'v2', 'v2a'])
    args = parser.parse_args()

    module = importlib.import_module(args.lang+'.arpa2ipa')
    # print(module.arpa2ipa("M IH S T ER <space> K W IH L T ER <space> IH Z".split()))

    for line in sys.stdin:
        utt_id = line.split()[0]
        line_arpa = line.split()[1:]
        ipa = module.arpa2ipa(line_arpa, args.version)
        outp = utt_id + ' ' + ' '.join(ipa)
        print(outp)