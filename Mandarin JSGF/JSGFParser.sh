#!/bin/bash
# Generate grammar file

# Input and output files
# =================================================================================
# Input
# Commands (after segmentation)
Input_file="$1" 

# Output
# JSGF grammar file name
Output_file="$2"

# Temporary files
Temp_file='temp_file.txt'
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
if [ -f $Output_file ] 
then 
     rm $Output_file # File exist.
else : # Do nothing!
fi 
# =================================================================================




# Initial Settings
# =================================================================================
echo '#JSGF V1.0;'      > $Output_file
echo -e ''             >> $Output_file
echo '/**'             >> $Output_file
echo ' * JSGF Grammar' >> $Output_file
echo ' */'             >> $Output_file
echo -e ''             >> $Output_file
echo 'grammar test;'   >> $Output_file
echo -e ''             >> $Output_file
echo \
"public <my_grammar> = \
/1/<commands>;"        >> $Output_file
echo -e "\n"           >> $Output_file
# =================================================================================




# Preprocessing
# =================================================================================
cat $Input_file > $Temp_file
sed -i '1 d' $Input_file 
# =================================================================================




# General Grammar
# =================================================================================
echo '<commands> = ' >> $Output_file

# label (self-defined)
sed -e 's/^/</' -e 's/$/>=/' $Input_file > temp1.txt
sed -e 's/$/;/' $Input_file > temp2.txt 
paste temp1.txt temp2.txt > jsgf_format_label.txt


# grammar (self-defined)
sed -e 's/^/</' -e 's/$/> | /' $Input_file > jsgf_format_grammar.txt
var=$(grep '|' jsgf_format_grammar.txt | tail -1 | sed 's/|//g')
sed -i '$d' jsgf_format_grammar.txt
echo $var >> jsgf_format_grammar.txt


# Print the result
cat jsgf_format_grammar.txt >> $Output_file
echo ";"                    >> $Output_file
echo -e "\n"                >> $Output_file
cat jsgf_format_label.txt   >> $Output_file
# =================================================================================




# Final Clean
# =================================================================================
cat $Temp_file > $Input_file

# Remove files
rm temp1.txt temp2.txt jsgf_format_label.txt jsgf_format_grammar.txt $Temp_file
# =================================================================================


