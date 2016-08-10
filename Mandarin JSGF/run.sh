#!/bin/bash
# Main Script

segmentation='segmentation.txt'

# Read input_file
read -p 'Please input your file : ' input_file

# Split Mandarin sentences
perl split_Mandarin.pl "$input_file" > $segmentation

# Delete white space (not used)
sed -i -e 's/^.//g' -e 's/ $//g' -e '/^$/d' $segmentation

./syl2phone.sh

#rm $segmentation



: << Comment
Generate files:
1. syl2phones.txt (sentence and phones)
2. dict.txt
3. phones.txt 
Comment



