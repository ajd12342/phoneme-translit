from pathlib import Path
import csv
import random
import sys

# Module that converts ARPA to IPA for Hindi. 
# May use language-specific rules so it is a per-language module.

def arpa2ipa(tokenized_arpa, version):
    own_file = Path(__file__)
    
    mapping = {}
    with open((own_file.parent)/'arpa2ipa.csv', 'r', newline='',encoding='utf-8') as csvfile:
        reader =  csv.reader(csvfile)
        for row in reader:
            mapping[row[0]] = row[1].split(',')
        mapping['<space>'] = ['<space>']
    
    with open((own_file.parent)/'arpavowels.txt', 'r',encoding='utf-8') as f:
        vowels = set([_.strip() for _ in f])

    with open((own_file.parent)/'arpaconsonants.txt', 'r',encoding='utf-8') as f:
        consonants = set([_.strip() for _ in f])

    missing = set()
    missing2 = set()

    ipa = []
    word_initial_positions = set([0]+ [i+1 for i, x in enumerate(tokenized_arpa) if x == "<space>"])
    word_final_positions = set([i-1 for i, x in enumerate(tokenized_arpa) if x == "<space>"]+[len(tokenized_arpa)-1])

    for i, arpa in enumerate(tokenized_arpa):
        if arpa in mapping:
            if len(mapping[arpa])==1:
                # Space will live here
                ipa.append(mapping[arpa][0])
            else:
                if arpa in vowels:
                    # If vowel, random choice
                    ipa.append(random.choice(mapping[arpa]))
                elif arpa in consonants:
                    if version == 'v1' or version == 'v1a':
                        # If consonant, if word-initial, use aspirated at index 1, else use index 0
                        if i in word_initial_positions and i not in word_final_positions and tokenized_arpa[i+1] in vowels:
                            ipa.append(mapping[arpa][1])
                        else:
                            ipa.append(mapping[arpa][0])
                    elif version == 'v2' or version == 'v2a':
                        # Always use unaspirated
                        ipa.append(mapping[arpa][0])
                else:
                    ipa.append(arpa)
                    missing2.add(arpa)
        else:
            ipa.append(arpa)
            missing.add(arpa)
    
    if missing or missing2:
        print(f"Warning: {missing} ARPABET are missing from the mapping and {missing2} from vowels+consonants."+ 
            f"Input: {tokenized_arpa}", file=sys.stderr)
    
    return ipa        
