#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# $1: Original input file
# $2: Lang
# $3: Version (v1 or v2)
# $3: tmpdir

tmpdir=$4
inpfilename=$(basename $1)

# Convert English ARPABET to [lang] IPA phonemes
python3 arpa2ipa.py --lang $2 --version $3 < $tmpdir/$inpfilename.arpa > $tmpdir/$inpfilename.$2.ipa