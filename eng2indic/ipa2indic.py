import argparse
import sys
import importlib

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--lang', required=True, choices=['hin'])
    parser.add_argument('--version', required=True, choices=['v1', 'v1a', 'v2', 'v2a'])

    args = parser.parse_args()

    module = importlib.import_module(args.lang+'.ipa2indic')

    for line in sys.stdin:
        utt_id = line.split()[0]
        line_ipa = line.split()[1:]
        txt = module.ipa2indic(line_ipa, args.version)
        outp = utt_id + ' ' + ''.join(txt)
        print(outp)