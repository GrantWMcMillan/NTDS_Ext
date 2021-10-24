#!/bin/bash
#NTDS Extractor - Ready for Hash Cat
# Written By GrantM - 30/06/21
# Updated 07/09/21 - Include LMHash Checks

file=$1

if [[ -f $file ]] && [[ -f SYSTEM ]]
then
#Extract Hashes and generate the list of Unique hashes ready for cracking.
	secretsdump.py -system SYSTEM -ntds $file -hashes lmhash:nthash -user-status -outputfile Hashes.txt local
	cat Hashes.txt.ntds | grep -v "\$:" | grep "status=Enabled" > DC_Hashes.txt
	cat DC_Hashes.txt | cut -d':' -f4 | sort -u > Hash_Only.txt


######################################################################################
#Grep and remove lines with Blank LMHash.
	cat DC_Hashes.txt | grep -v 'aad3b435b51404eeaad3b435b51404ee' >> LMHash.txt 
	
#Check for LMHash and Remove the file if there is no LMHash within the domain.
	if [ -s LMHash.txt ]; then
       	echo "This Domain has LMHASH!"
	else
        # The file is empty.
		echo " "
		echo "There is NO LMHash in this Domain!"
		echo " "
        rm -f LMHash.txt
	fi
#######################################################################################
#Make a List of all NTLM hashes 
	cat DC_Hashes.txt | cut -d':' -f4 >> NTLM_Hashes.txt
#Pick out Hashes that Duplicate Hashes
	cat NTLM_Hashes.txt | sort | uniq -d >> Duplicate_Hashes.txt
	
for i in `cat Duplicate_Hashes.txt`; do
	echo " " >> Shared_Passwords.txt 
	cat DC_Hashes.txt | grep $i >> Shared_Passwords.txt 
	echo " " >> Shared_Passwords.txt
done

#Delete the NTLM Hash file.
rm NTLM_Hashes.txt

	
else
	echo " "
	echo "The correct files do not exist in thie Directory"
	echo " "
fi

