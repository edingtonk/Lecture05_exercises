#!/bin/bash

# my answer - removing header and blank lines
# awk '{FS="\t"; OFS="\t"; if($1 != "name" && NF == 7){print $0}}' example_people_data.tsv > NoHeadPeopleData.tsv

unset IFS
IFS=$'\t'

count=0
while read name email city bday_day bday_month bday_yr country
do
# test returns t/f -z says true if length of string is equal to 0?
if test -z $name
 then
 echo -e "X\tBlank line found"
 else
 if test ["$country" == "country"]
  then
  echo -e "X\t Header line found"
  else
# can also do: count=$((count+1))
   let count=count+1
   echo -e "$count\t$country"
 fi # a real country
fi # a blank line
#echo -e "$name $email $city $bday_day $bday_month $bday_yr $country" >> "$country"
done < example_people_data.tsv


#awk '{FS="\t"; OFS="\t"; if($5 == "October"){print $1}}' NoHeadPeopleData.tsv > October.tsv
