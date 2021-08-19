#! /bin/bash

counter=0
count=`cat users.list.txt | cut -d , -f 2,3,4 |wc -l`


Usage()
{
script=$(basename -a ~/users_add.sh)
echo -e ""${script}" {arg1} is missing.
         where {arg1}: groups to be added in sequence. E.g. group1,group2 etc."
}

if [ "$#" -lt "1" ] ||  [ "$1" == "--help" ]
then
 Usage
 exit 
fi

#Check for any pre existing user_account file
if [ -f ~/existing_userid ]
then cat /dev/null > ~/existing_userid
fi

# Check if group exists

grep -i "$1" /etc/group
if [ "$?" != 0 ]
then
 #echo $?
 Group=`echo "$1" | xargs -d ',' -n1`
 for i in `echo "$Group"`
 do
 #echo $i
  groupadd $i
 done
else
 echo "Groups exists"
 exit
fi


while [ "${count}" -gt "${counter}" ]
do

comment=`awk 'NR=='$count'{print $0}' users.list.txt`

username=`awk 'NR=='$count'{print $0}' users.list.txt | cut -d , -f1`

useradd -c "${comment}"  -G "${1}" -d /home/"${username}" -m "${username}" 2>> existing_userid

echo -e "\n Listing user account information for "${username}" created by script"
grep  "${username}" /etc/passwd

((count=count-1))

done
