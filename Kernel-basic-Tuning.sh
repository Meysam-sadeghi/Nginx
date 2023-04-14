# Recommend changes to the kernel based on your server's resources.

#!/bin/bash

#Get the amount of RAM and number of CPU cores
total_ram=$(grep 'MemTotal' /proc/meminfo | awk '{print $2}')
num_cpu=$(grep -c ^processor /proc/cpuinfo)

#Calculate the values for kernel settings
kernel_sem=$((512 * num_cpu))
kernel_shmmax=$((total_ram / 2 * 1024 * 1024))
kernel_shmall=$((kernel_shmmax / 4096))
kernel_netcore_somaxconn=$((worker_connections * 2))

#Write the recommended kernel settings to sysctl.conf file
echo "

#Recommended Kernel Settings
kernel.sem = $kernel_sem $kernel_sem 512 512
kernel.shmmax = $kernel_shmmax
kernel.shmall = $kernel_shmall
net.core.somaxconn = $kernel_netcore_somaxconn
" >> /etc/sysctl.conf

#Apply the kernel settings
sysctl -p

#Output the recommended kernel settings
echo "Recommended Kernel Settings:"
echo " kernel.sem = $kernel_sem $kernel_sem 512 512"
echo " kernel.shmmax = $kernel_shmmax"
echo " kernel.shmall = $kernel_shmall"
echo " net.core.somaxconn = $kernel_netcore_somaxconn"
