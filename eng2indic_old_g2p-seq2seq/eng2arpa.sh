#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]
# Argument $3 - [tmpdir]

tmpdir=$3

inpfilename=$(basename $2)

# Make lowercase. g2p-seq2seq needs lowercase words
tr '[:upper:]' '[:lower:]' < $2 > $tmpdir/$inpfilename.lowerc

# Produce full list of words present in $2
python3 genwordlist.py < $tmpdir/$inpfilename.lowerc > $tmpdir/$inpfilename.wordlist

# Pass the list of words through g2p-seq2seq to get the corresponding ARPABET phonemes
g2p-seq2seq --decode $tmpdir/$inpfilename.wordlist --model_dir $1 --output $tmpdir/$inpfilename.arpalist

# Use the generate mapping to produce ARPABET version of $2. <space> token is used as whitespace 
python3 eng2arpa.py --arpa $tmpdir/$inpfilename.arpalist < $tmpdir/$inpfilename.lowerc > $tmpdir/$inpfilename.arpa

