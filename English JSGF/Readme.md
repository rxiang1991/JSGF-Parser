JSGF-Parser for English
=======================

Simple JSGF Parser of JSpeech Grammar Format (Recommended for CMU Sphinx)

(No installation)


Introduction
------------

Convert sentences to grammar.


Usage
-----

    $ ./syl2phone.sh  (Then type the name of the voice command file.)

    $ ./JSGFParser.sh command English.jsgf


Result
------

Dictionary: dict.txt

Grammar:    English.jsgf


pocketsphinx
------------

    $ pocketsphinx_continuous -infile test.wav -argfile config

Example config:
> -logfn /dev/null

> -hmm   hub4wsj_sc_8k

> -dict  dict.txt

> -jsgf  English.jsgf
