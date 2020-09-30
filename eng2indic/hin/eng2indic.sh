#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]
# Argument $3 - [lang]

./eng2arpa.sh $1 $2
echo "Eng to ARPABET done"
./arpa2ipa.sh $2 $3
echo "ARPABET to IPA done"
./ipa2indic.sh $2 $3
echo "Done."