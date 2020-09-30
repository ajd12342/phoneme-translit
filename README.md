# eng2indic

## Create project directory

WD: eng2hin

```bash
mkdir g2p
cd g2p
```

## Create a virtualenv and install dependencies

This is because CMU Sphinx works on specific older versions of Tensorflow and Tensor2Tensor

WD: eng2hin/g2p

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

WD: eng2hin/g2p

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

Let the text file path be `[input-text]` and the model path to the previously downloaded model be
`[model]`. Let the Indian language be [lang].
Currently supported: `hin`.
Then, run:

WD: eng2hin

```bash
./eng2indic.sh [model] [input-text] [lang] # Will be output to [input-text].hin.txt (change to whatever Shreya needs)
```

# eng2indic2

The setup is reduced to one line:

```
pip install g2p_en
```