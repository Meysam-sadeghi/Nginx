# Optimizing initial settings of Nginx according to server resources.
# The values are recommended and will not be changed.



#!/bin/bash

#Get the amount of RAM and number of CPU cores
total_ram=$(grep 'MemTotal' /proc/meminfo | awk '{print $2}')
num_cpu=$(grep -c ^processor /proc/cpuinfo)

#Calculate worker_processes for nginx
worker_processes=$((num_cpu * 2))

#Calculate worker_connections for nginx
if [[ $total_ram -lt 1048576 ]]; then # less than 1 GB
worker_connections=256
elif [[ $total_ram -lt 2097152 ]]; then # less than 2 GB
worker_connections=512
elif [[ $total_ram -lt 3145728 ]]; then # less than 3 GB
worker_connections=1024
elif [[ $total_ram -lt 4194304 ]]; then # less than 4 GB
worker_connections=2048
else # 4 GB or more
worker_connections=4096
fi


#Output the recommended settings
echo "Recommended Nginx settings:"
echo " worker_processes = $worker_processes"
echo " worker_connections = $worker_connections"
