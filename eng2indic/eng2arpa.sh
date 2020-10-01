#!/bin/bash

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Argument $1 - [input]
# Argument $2- [tmpdir]

tmpdir=$2

inpfilename=$(basename $1)

# Use the generate mapping to produce ARPABET version of $1. <space> token is used as whitespace 
python3 eng2arpa.py < $1 > $tmpdir/$inpfilename.arpa

