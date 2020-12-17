# Phoneme-based Transliteration

We present a rule-based algorithm to transliterate English text to Hindi text via an intermediate phonemic route.

First, the input English text is converted to English ARPABET phonemes using an off-the-shelf grapheme-to-phoneme converter, [g2p](https://github.com/Kyubyong/g2p). The ARPABET is an alphabet used to represent English phonemes; this alphabet was used to represent phonemes in the well-known CMUdict system.

Second, the English ARPABET phonemes are converted to Hindi IPA phonemes using an expert mapping. In this expert mapping, some vowels have multiple mappings; in this case, any one mapping is chosen uniformly at random. For stops, we use the aspirated phone when it appears in the word-initial position, otherwise the unaspirated phone.

Finally, the Hindi IPA phonemes are converted to Hindi text using an expert mapping and a rule-based algorithm as follows:
1. Convert all consonant phonemes to consonant graphemes using the mapping. For each consonant grapheme, if it is followed by nothing (end-of-word) or by an unresolved phoneme(so a vowel), keep as-is. If it is followed by a consonant, insert a _halantya_, the half-letter modifier.
2. Convert all vowel phonemes to vowels graphemes as follows: If it is preceded by nothing or by an unresolved phoneme(so a vowel), use the mapping's vowel as the conversion. If it is preceded by a consonant, use the mapping's diacritic.
3. Convert the following type of substring : _nasal consonant_ followed by _halantya_ to a single character, the _anuswaar_.

# Setting up
Use the code in the `eng2indic` folder. This is the best version. The `eng2indic_old_g2p-seq2seq` uses a different grapheme-to-phoneme convertor that does not work as well as the former.

## eng2indic

The setup is a one liner:

```bash
pip install g2p_en
```

Let the text file path be `[input]` and let its dir be `[input-dir]` and the filename of input
be `[input-filename]`.

Let the Indian language be `[lang]`. Currently supported: `hin`.

Use `[version]`=v1 if you want to use the rule 'aspirated when word-initial consonant followed by vowel'.
Use `[version]`=v2 if you want to use the rule 'unaspirated always'.

Then, run:

WD: eng2indic

```bash
./eng2indic.sh [input] [lang] [version] # Will be output to [input-dir]/.eng2[lang][version]/[input-filename].hin.txt
```

## eng2indic_old_g2p-seq2seq

### Create project directory

WD: eng2indic_old_g2p-seq2seq

```bash
mkdir g2p
cd g2p
```

### Create a virtualenv and install dependencies

This is because CMU Sphinx works on specific older versions of Tensorflow and Tensor2Tensor

WD: eng2indic_old_g2p-seq2seq/g2p

```bash
python3 -m venv g2p
source g2p/bin/activate
pip install -U pip
pip install -U setuptools
pip install -U wheel
pip install tensorflow==1.8.0
pip install tensor2tensor==1.6.6
```

### Clone and install g2p-seq2seq and download pretrained model

WD: eng2indic_old_g2p-seq2seq/g2p

```bash
git clone https://github.com/cmusphinx/g2p-seq2seq.git
cd g2p-seq2seq
python setup.py install
python setup.py test # Ensure it succeeds
cd ..
wget -O g2p-seq2seq-cmudict.tar.gz https://sourceforge.net/projects/cmusphinx/files/G2P%20Models/g2p-seq2seq-model-6.2-cmudict-nostress.tar.gz/download
tar xf g2p-seq2seq-cmudict.tar.gz
cd ..
```

### Run on the text dataset

Let the text file path be `[input]` and let its dir be `[input-dir]` and the filename of input
be `[input-filename]`.

Let model path to the previously downloaded model be `[model]`.

Let the Indian language be [lang].
Currently supported: `hin`.

Then, run:

WD: eng2indic_old_g2p-seq2seq

```bash
./eng2indic.sh [model] [input] [lang] # Will be output to [input-dir]/.eng2[lang][version]_old/[input-filename].hin.txt
```
