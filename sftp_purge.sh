#!/bin/bash

#####################################################
##############SFTP PURGING SCRIPT V.1################
##########AUTHOR:PEREZ, BRUCE A.#####################
#####################################################

target_dir=/home/ngap.sandbox.root/sftp/target_dir.txt

while IFS= read -r var
do
   find $var -mtime +90 -type f -print -delete 2>/dev/null
   find $var -size +1G -mtime +14 -type f -print -delete 2>/dev/null
done < $target_dir

echo Done