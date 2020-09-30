from pathlib import Path
import csv
import random
import sys

# Module that converts ARPA to IPA for Hindi. 
# May use language-specific rules so it is a per-language module.

def arpa2ipa(tokenized_arpa):
    own_file = Path(__file__)
    
    mapping = {}
    with open((own_file.parent)/'arpa2ipa.csv', 'r', newline='') as csvfile:
        reader =  csv.reader(csvfile)
        for row in reader:
            mapping[row[0]] = row[1].split(',')
        mapping['<space>'] = ['<space>']
    
    with open((own_file.parent)/'arpavowels.txt', 'r') as f:
        vowels = set([_.strip() for _ in f])

    with open((own_file.parent)/'arpaconsonants.txt', 'r') as f:
        consonants = set([_.strip() for _ in f])

    missing = set()

    ipa = []
    word_initial_positions = [0]+ [i+1 for i, x in enumerate(tokenized_arpa) if x == "<space>"]

    for i, arpa in enumerate(tokenized_arpa):
        if arpa in mapping:
            if len(mapping[arpa])==1:
                ipa.append(mapping[arpa][0])
            else:
                if arpa in vowels:
                    # If vowel, random choice
                    ipa.append(random.choice(mapping[arpa]))
                else:
                    # If consonant, if word-initial, use aspirated at index 1, else use index 0
                    if i in word_initial_positions:
                        ipa.append(mapping[arpa][1])
                    else:
                        ipa.append(mapping[arpa][0])
        else:
            ipa.append(arpa)
            missing.add(arpa)
    
    if missing:
        print(f"Warning: {missing} ARPABET are missing from the mapping. Input: {tokenized_arpa}", file=sys.stderr)
    
    return ipa        
