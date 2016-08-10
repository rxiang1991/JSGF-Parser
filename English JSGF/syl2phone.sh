#!/bin/bash
# Turn English sentences into phonemes



# Initial Settings
# ======================================================
dict='cmudict_SPHINX_40.txt'
convert_win='temp.txt'
temp_file1='temp1.txt'
temp_file2='temp2.txt'
temp_file3='temp3.txt'
temp_file4='temp4.txt'
temp_file5='temp5.txt'
temp_file6='temp6.txt'
temp_file7='temp7.txt'
output_file='phones.txt'
syl2phones='syl2phones.txt'
output_dict_temp='output_dict_temp.txt'
output_dict='dict.txt'
# ======================================================



# Input file
# ======================================================
input_file_temp='input_file_temp.txt'

# Read input_file
read -p 'Please input your file : ' input_file

cat "$input_file" > $input_file_temp

# Delete blank lines 
sed -i '/^$/d' "$input_file"  
# ======================================================



# Check file exists or not
# ======================================================
if [ -f $output_file ]
  then 
    # File exist.
    rm $output_file
  else
    # Do nothing 
    :
fi

if [ -f "$input_file" ]
then
  if [ -s "$input_file" ] 
    then
      echo "File $input_file exist and has data."
    else
      echo "File $input_file exist but is empty."
      exit 0
  fi
else
  echo "File $input_file does not exist."
  exit 0
fi
# ======================================================



# For Windows only: 
# ======================================================
# We need to use files that are in unix-format, 
# not DOS-format. To convert:
tr -d '\r' < "$input_file" > $convert_win
mv $convert_win "$input_file"  
# ======================================================

cat "$input_file" > $temp_file2



i=1
while [ "$i" != "0" ]
do
  sentence=$(sed -n '1p' $temp_file2)
  sed '1d' $temp_file2 > $temp_file3
  cat $temp_file3 > $temp_file2

# Turn lowercase to uppercase
# ======================================================
# '[:lower:]': 'a-z', '[:upper:]': 'A-Z'
string=$(echo "$sentence" | tr '[:lower:]' '[:upper:]')
# ======================================================

# Syllable to phones
# ======================================================
IFS=' ' read -r -a array <<< $string

for element in "${array[@]}"
do
  perl -ne "print $1 if /^$element[\t]/" $dict | \
  sed "s/.*$element[\t]//" >> $temp_file1
done
# ======================================================

# Turn multiple lines to one line and export output 
# ======================================================
paste -d' ' -s $temp_file1 > $temp_file4
cat $temp_file4 >> $output_file
# ======================================================
cat $temp_file1 >> $temp_file6
rm $temp_file1 

# Check if file empty
# ======================================================
if [ -s $temp_file2 ]
  then i=1
  else i=0
fi
# ======================================================

done



# Syllables and Phones
# ======================================================
awk '{l=length; if (l>x) x=l; a[NR]=$0} END {fstr="%-"x"s\n"; for(i=1;i<=NR;i++) printf(fstr, a[i])}' \
    "$input_file" > $temp_file5
paste $temp_file5 $output_file > $syl2phones

echo -e '\nResult:'
echo '--------------------------------------------------------'
paste $temp_file5 $output_file
echo -e '--------------------------------------------------------\n'
# ======================================================



# Export the dictionary
# ======================================================
tr ' ' '\n' < "$input_file" | xargs -n 1 | tr ' ' ' ' > $temp_file7
awk '{l=length; if (l>x) x=l; a[NR]=$0} END {fstr="%-"x"s\n"; for(i=1;i<=NR;i++) printf(fstr, a[i])}' \
    "${temp_file7}" > "${temp_file7}.tmp" ; mv "${temp_file7}.tmp" "${temp_file7}"

paste $temp_file7 $temp_file6 > $output_dict_temp

# Remove duplicate lines inside a text file
awk '!seen[$0]++' $output_dict_temp > $output_dict
# ======================================================



cat $input_file_temp > "$input_file"
rm $temp_file2 $temp_file3 $temp_file4 $temp_file5 \
   $temp_file6 $temp_file7 $output_dict_temp \
   $input_file_temp



: << Comment
Generate files:
1. syl2phones.txt (sentence and phones)
2. dict.txt
3. phones.txt 
Comment



