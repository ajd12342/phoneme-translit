#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]
# Argument $3 - [output]

tr '[:upper:]' '[:lower:]' < $2 > $2.lowerc

python3 genwordlist.py < $2.lowerc > $2.wordlist

g2p-seq2seq --decode $2.wordlist --model_dir $1 --output $2.arpalist 

python3 eng2arpa.py --arpa $2.arpalist < $2.lowerc > $2.arpa

# Convert to Hindi phonemes as IPA

# Convert to Hindi graphemes

# while IFS= read -r line; do
#     read -a linearray <<< $line
#     uttid=${linearray[0]}
#     words=("${linearray[@]:1}")
#     # echo "${words[@]}" | tr ' ' '\n'
#     transcript=$(g2p-seq2seq --decode <(echo "${words[@]}" | tr ' ' '\n') --model_dir $1 )
#     # echo $transcript
#     # sleep 1
# done < $2