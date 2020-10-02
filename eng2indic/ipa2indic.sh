#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# $1: Original input file
# $2: Lang
# $3: version (v1 or v1a or v2 or v2a)
# $4: tmpdir

tmpdir=$4
inpfilename=$(basename $1)

# Convert [lang] phonemes to [lang] graphemes
python3 ipa2indic.py --lang $2 --version $3 < $tmpdir/$inpfilename.$2.ipa > $tmpdir/$inpfilename.$2.txt