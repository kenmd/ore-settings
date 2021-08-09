#!/bin/bash -eu

# check cpu for symantec processes and kill if more than 50%
# sudo crontab -l
# */1 * * * * mkdir -p /tmp/killsym/ && ~/bin/kill-symantec-by-cpu.sh > /tmp/killsym/$$.txt 2> /tmp/killsym/$$.err

echo $(date)

SYM_CPU=$(ps -A -c -o "pid command %cpu" | grep com.symantec.mes | awk '{print $3}')
echo "SYM_CPU com.symantec.mes: $SYM_CPU"

if (( ${SYM_CPU%%.*} > 50 )); then
    SYM_PID=$(ps -A -c -o "pid command %cpu" | grep com.symantec.mes | awk '{print $1}')
    echo "Killing com.symantec.mes: $SYM_PID"
    kill -9 $SYM_PID
fi

SYM_CPU=$(ps -A -c -o "pid command %cpu" | grep SymDaemon | awk '{print $3}')
echo "SYM_CPU SymDaemon: $SYM_CPU"

if (( ${SYM_CPU%%.*} > 50 )); then
    SYM_PID=$(ps -A -c -o "pid command %cpu" | grep SymDaemon | awk '{print $1}')
    echo "Killing SymDaemon: $SYM_PID"
    kill -9 $SYM_PID
fi
