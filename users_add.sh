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

if [ -f ~/user_account.exists ]
then cat /dev/null > ~/user_account.exists
fi

while [ "${count}" -gt "${counter}" ]
do

comment=`awk 'NR=='$count'{print $0}' users.list.txt`

username=`awk 'NR=='$count'{print $0}' users.list.txt | cut -d , -f1`

useradd -c "${comment}" -d /home/"${username}" -m "${username}" 2>> user_account.exists
usermod -G "${username}","${1}" "${username}"

echo -e "\n Listing user account information for "${username}" created by script"
grep  "${username}" /etc/passwd

((count=count-1))

done
