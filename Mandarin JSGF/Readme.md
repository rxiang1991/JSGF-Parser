JSGF-Parser for Mandarin
========================

Simple JSGF Parser of JSpeech Grammar Format (Recommended for CMU Sphinx)

(No installation)


Introduction
------------

Convert sentences to grammar.


Usage
-----
```shell
$ ./run.sh
(Then type the name of the voice command file.)

$ ./JSGFParser.sh segmentation.txt Mandarin.jsgf
```

Result
------

Dictionary: dict.txt

Grammar:    Mandarin.jsgf


pocketsphinx
------------

$ pocketsphinx -infile test.wav -argfile config

Example config:
> -logfn /dev/null

> -hmm   tdt_sc_8k

> -dict  dict.txt

> -jsgf  Mandarin.jsgf
