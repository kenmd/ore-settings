#!/bin/bash -eux

# Usage:
# * show logs from 10 min ago to now
# aws_logs.sh /aws/lambda/MyFunction 10M
# * show logs from 1 hour ago to 30 min ago
# aws_logs.sh /aws/lambda/MyFunction 1H 30M
# * show logs from 1 hour ago to 30 min ago including INFO
# aws_logs.sh /aws/lambda/MyFunction 1H 30M INFO
# * show logs from 1 hour ago to 30 min ago excluding INFO
# aws_logs.sh /aws/lambda/MyFunction 1H 30M -INFO

logGrp=$1       # /aws/lambda/MyFunction
begAgo=$2       # 10M (10 minutes)
endAgo=${3-0M}  # default 0M (now)
filter=${4-}    # default "" (no filter)

# Mac date math format: -v[+/-](number)[ymwdHMS]
# https://stackoverflow.com/questions/498358

begtime="$(date -v-${begAgo} -u +%s)000"
endtime="$(date -v-${endAgo} -u +%s)000"
# +%s unix time https://qiita.com/albatross/items/b97df73dcfcedabb070d

aws logs filter-log-events \
    --log-group-name $logGrp \
    --start-time $begtime \
    --end-time $endtime \
    --filter-pattern="$filter" \
    --output json \
    | jq -r '.events[] | "\(.timestamp) \(.message)"' \
    | grep "\S" \
    | column -t -s"$(printf '\t')" \
    | awk '{"date -r "int($1/1000)" \"+%Y/%m/%d %H:%M:%S\"" | getline t; $1=t; print }'

# c.f.
# Using jq to parse and display multiple fields in a json serially
# https://stackoverflow.com/questions/28164849
# Convert unix epoch time to human readable date on Mac OSX - BSD
# https://stackoverflow.com/questions/21958851
# awk system() and getline sample
# https://orebibou.com/ja/home/201707/20170723_001/
