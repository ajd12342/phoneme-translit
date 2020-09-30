#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]
# Argument $3 - [lang]

tmpdir="$(dirname "$2")"/.eng2$3
mkdir -p $tmpdir

# ./eng2arpa.sh $1 $2 $tmpdir
# echo "Eng to ARPABET done"
# ./arpa2ipa.sh $2 $3 $tmpdir
# echo "ARPABET to IPA done"
./ipa2indic.sh $2 $3 $tmpdir
# Rename to filename desired by Shreya

# echo "Done."