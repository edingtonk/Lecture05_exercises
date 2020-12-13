#!/bin/bash

# my answer - removing header and blank lines
# awk '{FS="\t"; OFS="\t"; if($1 != "name" && NF == 7){print $0}}' example_people_data.tsv > NoHeadPeopleData.tsv

unset IFS
IFS=$'\t'

# remember -le and -ge flags can be used with test = less than or equal to/greater than or equal to
# -eq is equal to

# fnr is the record number (usually line no)
count=0 ;fnr=0
month=10
wantedcountry="Mozambique"
inputfile="example_people_data.tsv"
# saying cut the wc output at the first space
inputfilelength=$(wc -l $inputfile | cut -d ' ' -f1)
outfile="Country.$wantedcountry.details"

unset my_array
# -a means it is associative, i.e. keys are strings not ints
declare -A my_array

while read name email city bday_day bday_month bday_yr country
do
fnr=$((fnr+1))
echo -e "Line number is: $fnr"
# test returns t/f -z says true if length of string is equal to 0?
if test -z $name || test $country == "country"
 then
 continue
 else
# escape chars to remove spaces - says remove space and replace with nothing
# echo -e "Outfile will be ${country// /}.details";
# can also do: let count=count+1
# count=$((count+1))
# counter with index and country
# echo -e "$count\t$country"
# outputs each country into separate files
# echo -e "$count\t$name\t$email\t$city\t$bday_day\t$bday_month\t$bday_yr\t$country" >> ${country// /}.details
# looking at October bdays
# if test $bday_month -eq $month
#  then
#  echo -e "$count\t$name\t$bday_month\t$country" >> October.tsv
# fi
 if test $country == $wantedcountry
  then
  count=$((count+1));
  my_array[$count]="$fnr\t$name\t$country"
#  echo -e "${my_array[$count]}"
 fi
fi
if test $fnr -eq $inputfilelength
 then
 echo -e "\n### Here are the end of file results for $wantedcountry:" > $outfile
 for i in "${my_array[@]}"; do echo -e "$i" >> $outfile; done
fi
done < $inputfile 

# Printing the number of Oct bdays
# OctBdays=$(wc -l October.tsv)
# Specifying first 2 chars
# echo -e "The number of October birthdays is: ${OctBdays:0:2}"
