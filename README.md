# NTDS_Extr

A quick script I use on my PATH variable witin Kali to save me time on a test looking up multiple commands.

The script will
 - Uses SecretDump.py to extract the NTDS.dit file.
 - Removes computer account
 - Removes disabled accounts
 - Removes the (Enabled) at the end of thr NTDS file.
 - Creates a Clened up version of the NTDS file - "DC_Hash.txt"
 - Finally it cuts out the NTLM Hashes, sorts these unique and puts them into a file (Hash Only.txt) ready for hashcat -1000 cracking.
