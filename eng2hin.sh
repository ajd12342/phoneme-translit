#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [model]
# Argument $2 - [input]
# Argument $3 - [output]

temp_file_engwords2arpawords=$(mktemp)
python3 engwords2arpawords.py --model $1 < $1 > $temp_file_engwords2arpawords

python3 eng2arpa.py --map temp_file_engwords2arpawords < $1 > $1.arpabet

while IFS= read -r line; do
    read -a linearray <<< $line
    uttid=${linearray[0]}
    words=("${linearray[@]:1}")
    # echo "${words[@]}" | tr ' ' '\n'
    transcript=$(g2p-seq2seq --decode <(echo "${words[@]}" | tr ' ' '\n') --model_dir $1 )
    # echo $transcript
    # sleep 1
done < $2