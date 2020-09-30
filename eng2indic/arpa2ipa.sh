#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# $1: Original input file
# $2: Lang

# Convert English ARPABET to [lang] IPA phonemes
python3 arpa2ipa.py --lang $2 < $1.arpa > $1.$2.ipa