#!/bin/bash -eux

# aws_s3_grep.sh
# grep files on S3 without downloading using S3 Select
#
# Sample Usage:
#
# aws_s3_grep.sh mybucket myfolder/myfile.html 101
# grep 101 from s3://mybucket/myfolder/myfile.html
#
# aws_s3_grep.sh mybucket myfolder/myfile\*.html 101
# grep 101 from S3 files start with myfolder/myfile and end with .html

BUCKET=$1
KEYPATTERN=$2
KEYWORD=$3

# https://qiita.com/koara-local/items/04d3efd1031ea62d8db5
PREFIX=${KEYPATTERN%\**}    # myfolder/myfile
POSTFIX=${KEYPATTERN#*\*}   # .html

KEYS=($(aws s3 ls s3://$BUCKET/$PREFIX --recursive | awk '{print $4}' | grep $POSTFIX))

outfile=/tmp/aws_s3_grep_$$.txt
rm -f $outfile

for KEY in ${KEYS[@]}; do
    tmpfile=/tmp/aws_s3_grep_$RANDOM.tmp
    rm -f $tmpfile

    aws s3api select-object-content \
        --bucket $BUCKET \
        --key $KEY \
        --expression "SELECT * FROM S3Object WHERE _1 LIKE '%${KEYWORD}%'" \
        --expression-type SQL \
        --input-serialization '{"CSV": {}}' \
        --output-serialization '{"CSV": {}}' \
        $tmpfile

    # https://serverfault.com/questions/310098
    cat $tmpfile | while IFS= read -r line; do
        printf '%s %s\n' $KEY "$line"
    done >> $outfile

    rm -f $tmpfile
done

cat $outfile
rm -f $outfile
