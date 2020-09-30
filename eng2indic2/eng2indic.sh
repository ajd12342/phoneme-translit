#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [input]
# Argument $2 - [lang]

tmpdir="$(dirname "$1")"/.eng2$2v2
mkdir -p $tmpdir

./eng2arpa.sh $1 $tmpdir
echo "Eng to ARPABET done"
./arpa2ipa.sh $1 $2 $tmpdir
echo "ARPABET to IPA done"
./ipa2indic.sh $1 $2 $tmpdir
echo "IPA to" $2 "done"
# Rename to filename desired by Shreya

echo "Done."