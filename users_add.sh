#! /bin/bash
counter=0
count=`cat users.list.txt | cut -d , -f 2,3,4 |wc -l`

if [ -f ~./user_account.existsi ]
then cat /dev/null > ~./user_account.exists
fi

while [ "${count}" -gt "${counter}" ]
do
#echo $count

comment=`awk 'NR=='$count'{print $0}' users.list.txt`
#echo $comment

username=`awk 'NR=='$count'{print $0}' users.list.txt | cut -d , -f1`
#echo $username

useradd -c "${comment}" -d /home/"${username}" -m "${username}" 2>> user_account.exists

echo -e "\n Listing user account information for "${username}" created by script"
grep  "${username}" /etc/passwd

((count=count-1))

done
