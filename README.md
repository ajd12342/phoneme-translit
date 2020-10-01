# eng2indic

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

# eng2indic_old_g2p-seq2seq
Don't use this one.

## Create project directory

WD: eng2indic_old_g2p-seq2seq

```bash
mkdir g2p
cd g2p
```

## Create a virtualenv and install dependencies

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

## Clone and install g2p-seq2seq and download pretrained model

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

## Run on the text dataset

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
