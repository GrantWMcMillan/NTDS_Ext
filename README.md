# NTDS_Extr

A quick script I use on my PATH variable within Kali to save me time on a test looking up multiple commands.

The script will
 - Uses SecretDump.py to extract the ntds.dit file.
 - Removes Computer Account ($)
 - Removes Disabled Accounts
 - Removes the (Enabled) at the end of the NTDS file.
 - Creates a clened up version of the NTDS file - "DC_Hash.txt"
 - Finally it cuts out the NTLM Hashes, sorts the hashes by unique and puts them into a file (Hash Only.txt) ready for hashcat -1000 cracking.


Update:
Greps out LMHashes there they are not blank.
Finds Shared NTLm Hashes and then greps out the usernames that are sharing a password.
