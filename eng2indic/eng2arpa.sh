#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]

tmpdir=.engtmp
mkdir -p $tmpdir

inpfilename=$(basename $2)

# Make lowercase. g2p-seq2seq needs lowercase words
tr '[:upper:]' '[:lower:]' < $2 > $tmpdir/$inpfilename.lowerc

# Produce full list of words present in $2
python3 genwordlist.py < $tmpdir/$inpfilename.lowerc > $tmpdir/$inpfilename.wordlist

# Pass the list of words through g2p-seq2seq to get the corresponding ARPABET phonemes
g2p-seq2seq --decode $tmpdir/$inpfilename.wordlist --model_dir $1 --output $tmpdir/$inpfilename.arpalist

# Use the generate mapping to produce ARPABET version of $2. <space> token is used as whitespace 
python3 eng2arpa.py --arpa $tmpdir/$inpfilename.arpalist < $tmpdir/$inpfilename.lowerc > $2.arpa

./arpa2ipa.sh $2 $3
# while IFS= read -r line; do
#     read -a linearray <<< $line
#     uttid=${linearray[0]}
#     words=("${linearray[@]:1}")
#     # echo "${words[@]}" | tr ' ' '\n'
#     transcript=$(g2p-seq2seq --decode <(echo "${words[@]}" | tr ' ' '\n') --model_dir $1 )
#     # echo $transcript
#     # sleep 1
# done < $2