#!/bin/bash

# removing header and blank lines
awk '{FS="\t"; OFS="\t"; if($1 != "name" && NF == 7){print $0}}' example_people_data.tsv > NoHeadPeopleData.tsv

#IFS="\t"

count=0
while read name email city bday_day bday_month bday_yr country
do
let count=count+1
echo -e "$count $name $city $country"
#echo -e "$name $email $city $bday_day $bday_month $bday_yr $country" >> "$country"
done < NoHeadPeopleData.tsv


awk '{FS="\t"; OFS="\t"; if($5 == "October"){print $1}}' NoHeadPeopleData.tsv > October.tsv
