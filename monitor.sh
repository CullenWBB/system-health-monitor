#!/bin/bash

# Configuration
LOG_FILE="$HOME/projects/system_monitor/health_log.txt"
THRESHOLD=80

echo "=== System Health Check: $(date) ===" >> $LOG_FILE

# 1. Check Disk Usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: ${DISK_USAGE}%" >> $LOG_FILE

if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is above ${THRESHOLD}%!" >> $LOG_FILE
fi

# 2. Check Memory (RAM) Usage
FREE_MEM=$(free -m | awk 'NR==2 {print $4}')
echo "Available Memory: ${FREE_MEM}MB" >> $LOG_FILE

# 3. Log Top 3 CPU Consuming Processes
echo "Top 3 CPU Consuming Processes:" >> $LOG_FILE
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 4 >> $LOG_FILE

echo "----------------------------------------" >> $LOG_FILE
echo "Health check complete. Appended to $LOG_FILE"
