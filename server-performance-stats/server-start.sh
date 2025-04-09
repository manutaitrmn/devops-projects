#!/bin/bash

echo "==== SYSTÈME MONITORING ===="
  
# CPU Usage en pourcentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage : $cpu_usage%"

# Memory Usage en pourcentage
mem_info=$(free -m | grep Mem:)
total_mem=$(echo $mem_info | awk '{print $2}')
used_mem=$(echo $mem_info | awk '{print $3}')
free_mem=$(echo $mem_info | awk '{print $4}')

mem_usage_percent=$(( 100 * used_mem / total_mem ))
mem_free_percent=$(( 100 * free_mem / total_mem ))

echo "Memory Usage :"
echo "   - Total : ${total_mem} MB"
echo "   - Used  : ${used_mem} MB (${mem_usage_percent}%)"
echo "   - Free  : ${free_mem} MB (${mem_free_percent}%)"

# Disk Usage en pourcentage (sur la partition root "/")
disk_info=$(df -h / | awk 'NR==2 {print $2, $3, $4, $5}')
used_disk=$(echo $disk_info | awk '{print $2}')
free_disk=$(echo $disk_info | awk '{print $3}')
total_disk=$(echo $disk_info | awk '{print $1}')
disk_usage_percent=$(echo $disk_info | awk '{print $4}' | sed 's/%//')
disk_free_percent=$((100 - $disk_usage_percent))

echo "Disk Usage (/ partition) :"
echo "   - Total : $total_disk"
echo "   - Used  : $used_disk (${disk_usage_percent}%)"
echo "   - Free  : $free_disk (${disk_free_percent}%)"

top_5_processes_by_cpu=$(ps -eo comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{print "   - " $1, "(" $2 "%)"}')
echo "Top 5 processes by CPU usage :"
echo "$top_5_processes_by_cpu"

top_5_processes_by_memory=$(ps -eo comm,%mem --sort=-%mem | head -n 6 | tail -n 5 | awk '{print "   - " $1, "(" $2 "%)"}')
echo "Top 5 processes by memory usage :"
echo "$top_5_processes_by_memory"

echo "============================"
