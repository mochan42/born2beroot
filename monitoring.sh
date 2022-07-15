#!/bin/bash
wall $'#Architecture: ' `hostnamectl | grep "Kernel" | cut -d ':' -f 2-` `hostnamectl | grep "Operating System" | cut -d ':' -f 2- ` `awk -F':' '/model name/ {print $2}' /proc/cpuinfo` `arch` \
$'\n#CPU physical: '`cat /proc/cpuinfo | grep "^processor" | wc -l` \
$'\n#vCPU:  '`cat /proc/cpuinfo | grep "cpu core" | wc -l` \
$'\n'`free -m | awk '/Mem/{printf "#Memory Usage: %s/%s MB (%.2f%%)", $3,$2,$3*100/$2 }'` \
$'\n'`df -h -BM | awk 'NR>1 {sum1 += $3}{sum2 += $2}{sum3 = sum1*100/sum2} END {printf "#Disk Usage: %d/%d MB (%.1f%%)", sum1,sum2,sum3}'` \
$'\n'#CPU Load : `top -bn1 | grep load | cut -d ',' -f 4- | cut -d ',' -f 2-` %\
$'\n#Last boot: ' `who -b | awk '{print $3, $4}'` \
$'\n#LVM use: ' `lsblk |grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"} }'` \
$'\n#Connections TCP: ' `netstat -an | grep ESTABLISHED |  wc -l` ESTABLISHED\
$'\n#User log: ' `who | cut -d " " -f 1 | sort -u | wc -l` \
$'\nNetwork: IP ' `hostname -I`"("`ip a | grep link/ether | awk '{print $2}'`")" \
$'\n#Sudo:  ' `grep -a 'COMMAND=' /var/log/sudo/sudo.log | wc -l` cmd