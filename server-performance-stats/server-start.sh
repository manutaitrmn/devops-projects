#!/bin/bash

echo "==== SYSTÈME MONITORING ===="
  
# CPU Usage en pourcentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "🧠 CPU Usage : $cpu_usage%"

# Memory Usage en pourcentage
mem_info=$(free -m | grep Mem:)
total_mem=$(echo $mem_info | awk '{print $2}')
used_mem=$(echo $mem_info | awk '{print $3}')
free_mem=$(echo $mem_info | awk '{print $4}')

mem_usage_percent=$(( 100 * used_mem / total_mem ))
mem_free_percent=$(( 100 * free_mem / total_mem ))

echo "💾 Memory Usage :"
echo "   - Total : ${total_mem} MB"
echo "   - Used  : ${used_mem} MB (${mem_usage_percent}%)"
echo "   - Free  : ${free_mem} MB (${mem_free_percent}%)"

# Disk Usage en pourcentage (sur la partition root "/")
disk_info=$(df -h / | awk 'NR==2 {print $3, $4, $5}')
used_disk=$(echo $disk_info | awk '{print $1}')
free_disk=$(echo $disk_info | awk '{print $2}')
disk_usage_percent=$(echo $disk_info | awk '{print $3}' | sed 's/%//')

echo "💿 Disk Usage (/ partition) :"
echo "   - Used  : $used_disk (Used: ${disk_usage_percent}%)"
echo "   - Free  : $free_disk"

echo "============================"
