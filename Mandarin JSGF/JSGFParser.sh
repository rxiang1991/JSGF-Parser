#!/bin/bash
# Generate JSGF grammar for speech recognition



# Input and output files
# =================================================================================
# Input
# Commands
Input_file="$1" 

# Output
# JSGF grammar file name
Output_file="$2"

# Temporary files
Temp_file='temp_file.txt'
paste_temp1='temp1.txt'
paste_temp2='temp2.txt'
JSGF_rulename='rulename.txt'
JSGF_token='token.txt'
# =================================================================================



# Detect whether grammar file name exist or not
# =================================================================================
if [ -z "$1" ] || [ -z "$2" ]
then
  echo 'Usage: ./JSGFParser.sh [Input FILE] [Output FILE]'
  echo 'Generate Grammar for Speech Recogntion.'
  echo -e ''
  echo 'Recommend 1: ./JSGFParser.sh segmentation.txt Mandarin.jsgf'
  echo 'Recommend 2: ./JSGFParser.sh command English.jsgf'
  exit
fi
# =================================================================================



# Remove existed grammar file
# =================================================================================
if [ -f "$Output_file" ]
then
  # File exist.
  rm "$Output_file" 
else
  # Do nothing!
  :
fi
# =================================================================================



# Initial Settings
# =================================================================================
{
  echo '#JSGF V1.0;'
  echo -e ''
  echo '/**'
  echo ' * JSGF Grammar for simple voice commands'
  echo ' *'
  echo ' * @author William Liao'
  echo ' * @version 1.0'
  echo ' * @example open the window'
  echo ' */'
  echo -e ''
  echo 'grammar voice_commands;'
  echo -e ''
  echo \
  "public <my_grammar> = /1/ <commands>;"
  echo -e "\n"
} >> "$Output_file"
# =================================================================================



# Save temporary file
# =================================================================================
cat "$Input_file" > $Temp_file
# =================================================================================



# General Grammar
# =================================================================================
echo '<commands> = ' >> "$Output_file"

# label (self-defined)
sed -e 's/^/</' -e 's/$/>=/' "$Input_file" > $paste_temp1
sed -e 's/$/;/' "$Input_file" > $paste_temp2
paste $paste_temp1 $paste_temp2 > $JSGF_rulename


# grammar (self-defined)
sed -e 's/^/</' -e 's/$/> | /' "$Input_file" > $JSGF_token
var=$(grep '|' $JSGF_token | tail -1 | sed 's/|//g')
sed -i '$d' $JSGF_token
echo "$var" >> $JSGF_token


# Print the result
{
  cat $JSGF_token
  echo ";"
  echo -e "\n"
  cat $JSGF_rulename
  echo -e "\n"
} >> "$Output_file"
# =================================================================================



# Final Clean
# =================================================================================
cat $Temp_file > "$Input_file"

# Remove temporary files
rm $Temp_file $paste_temp1 $paste_temp2 $JSGF_rulename $JSGF_token
# =================================================================================



: << Comment

References:

1. JSpeech Grammar Format
   https://www.w3.org/TR/jsgf/

2. Building a grammar
   http://cmusphinx.sourceforge.net/wiki/tutoriallm

Comment



