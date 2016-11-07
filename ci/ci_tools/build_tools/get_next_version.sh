#!/usr/bin/env bash
if [ $# -ne 2 ]
then
  echo "please input the directory and prefix"
  echo "eg: get_next_version.sh ./ ias"
  exit 1
fi

items=`ls $1 |egrep $2 |egrep "[0-9]+\.[0-9]+\.[0-9]+" -o`

#to find largest version
largest_n1=1
largest_n2=0
largest_n3=0

for ITEM in $items
do
  current_n1=`echo $ITEM |cut -d. -f1`
  current_n2=`echo $ITEM |cut -d. -f2`
  current_n3=`echo $ITEM |cut -d. -f3`

  if [ $current_n1 -gt $largest_n1 ]
  then
    largest_n1=$current_n1
    largest_n2=$current_n2
    largest_n3=$current_n3 
    continue
  elif [ $current_n1 -lt $largest_n1 ]
  then
    continue    
  fi   

  if [ $current_n2 -gt $largest_n2 ]
  then
    largest_n1=$current_n1
    largest_n2=$current_n2
    largest_n3=$current_n3
    continue
  elif [ $current_n2 -lt $largest_n2 ]
  then
    continue
  fi

  if [ $current_n3 -gt $largest_n3 ]
  then
    largest_n1=$current_n1
    largest_n2=$current_n2
    largest_n3=$current_n3   
  fi
done

if [ $largest_n3 -lt 99 ]
then
  largest_n3=`expr $largest_n3 + 1`
elif [ $largest_n2 -lt 99 ]
then
  largest_n2=`expr $largest_n2 + 1`
  largest_n3=0
else
  largest_n1=`expr $largest_n1 + 1`
  largest_n2=0
  largest_n3=0
fi

echo "$largest_n1.$largest_n2.$largest_n3"


