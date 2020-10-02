#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [input]
# Argument $2 - [lang]
# Argument $3 - [v1 or v2]

tmpdir="$(dirname "$1")"/.eng2$2$3
mkdir -p $tmpdir

./eng2arpa.sh $1 $tmpdir
echo "Eng to ARPABET done"
./arpa2ipa.sh $1 $2 $3 $tmpdir
echo "ARPABET to IPA done"
./ipa2indic.sh $1 $2 $tmpdir
echo "IPA to" $2 "done"

inpfilename=$(basename $1)
filename="$1"_"$2""$3"

# moving the needed file out of the temp directory
echo "Moving " $tmpdir/$inpfilename.$2.txt "to" $filename "done"
mv $tmpdir/$inpfilename.$2.txt $filename

# rm -r $tmpdir
echo "Done"
