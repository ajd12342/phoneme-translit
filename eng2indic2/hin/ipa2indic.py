from csv import Error
from pathlib import Path
import csv
import random
import sys

# Module that converts IPA to graphemes for Hindi. 
# May use language-specific rules so it is a per-language module.

def ipa2indic(tokenized_ipa):
    own_file = Path(__file__)
    
    mapping = {}
    with open((own_file.parent)/'ipa2indic.csv', 'r', newline='') as csvfile:
        reader =  csv.reader(csvfile)
        for row in reader:
            mapping[row[0]] = row[1].split(',')
        mapping['<space>'] = [' ']
    
    with open((own_file.parent)/'ipavowels.txt', 'r') as f:
        vowels = set([_.strip() for _ in f])

    with open((own_file.parent)/'ipaconsonants.txt', 'r') as f:
        consonants = set([_.strip() for _ in f])

    indic = [_ for _ in tokenized_ipa]
    is_consonant = [False for _ in tokenized_ipa]
    word_initial_positions = set([0]+ [i+1 for i, x in enumerate(tokenized_ipa) if x == "<space>"])
    word_final_positions = set([i-1 for i, x in enumerate(tokenized_ipa) if x == "<space>"]+[len(tokenized_ipa)-1])

    # Initial conversions
    for i, ipa in enumerate(indic):
        if ipa in mapping:
            if ipa in consonants:
                # Map consonants
                indic[i] = mapping[ipa][0]
                is_consonant[i] = True
            elif ipa in vowels:
                # Don't map for now
                pass
            elif ipa=='<space>':
                indic[i] = mapping[ipa][0]
            else:
                raise Exception(f"Unknown IPA in vowel+consonants {ipa}")
        else:
            raise Exception(f"Unknown IPA {ipa}")
    
    # Add halantyas
    for i, symb in enumerate(indic):
        if is_consonant[i]:
            if not i in word_final_positions and is_consonant[i+1]:
                # Consonant followed by consonant, so halantya
                indic[i] = symb+'्'
    
    # Convert vowels
    for i, symb in enumerate(indic):
        if not is_consonant[i] and tokenized_ipa[i]!='<space>':
            if i in word_initial_positions or not is_consonant[i-1]:
                # Preceded by nothing, or by a vowel
                indic[i] = mapping[symb][0]
            else:
                # Preceded by something, which is a consonant
                indic[i] = mapping[symb][1]
    
    return indic