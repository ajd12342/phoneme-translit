#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# $1: Original input file
# $2: Lang

# Convert [lang] phonemes to [lang] graphemes
python3 ipa2indic.py --lang $2 < $1.$2.ipa > $1.$2.txt