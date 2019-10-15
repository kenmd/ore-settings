#!/bin/bash -eux

AWS_PROFILE=xxxxxxxxxx
ACCOUNT_ID=000000000000

ROLE_NAME=xxxxxxxxxx

# Super simple script to use AWS CLI with SAML federation account.
# replacement of saml2aws in case you had trouble of Captcha image.
#
# Usage:
# show URL for SAML: mysaml2aws.sh
# create credentials: mysaml2aws.sh xxxxxxxxxx... (SAMLResponse from the URL)
#
# See:
# https://aws.amazon.com/premiumsupport/knowledge-center/aws-cli-call-store-saml-credentials/
# https://aws.amazon.com/jp/premiumsupport/knowledge-center/aws-cli-call-store-saml-credentials/

ROLE_ARN=arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME
PRINCIPAL_ARN=arn:aws:iam::$ACCOUNT_ID:saml-provider/G-Suite

IDPID=xxxxxxxxx
SPID=000000000000
URL="https://accounts.google.com/o/saml2/initsso?idpid=${IDPID}&spid=${SPID}&forceauthn=false"

SAML="${1:-}"

[[ -z "${SAML}" ]] && { echo "$URL" ; exit 1; }

eval `aws sts assume-role-with-saml \
    --role-arn $ROLE_ARN --principal-arn $PRINCIPAL_ARN --saml-assertion $SAML | \
jq -r '.Credentials | to_entries | map("\(.key)=\(.value)") | .[]'`

# eval the output
# AccessKeyId=xxxxx...
# SecretAccessKey=xxxxx...
# SessionToken=xxxxx...
# Expiration=xxxxx...

# reference script:
# MacからAWSにアクセスする時はAssumeRoleすることにした
# https://qiita.com/ryo0301/items/0730e4b1068707a37c31

# these go to .aws/config
aws configure --profile $AWS_PROFILE set region ap-northeast-1
aws configure --profile $AWS_PROFILE set output json
# these go to .aws/credentials
aws configure --profile $AWS_PROFILE set aws_access_key_id $AccessKeyId
aws configure --profile $AWS_PROFILE set aws_secret_access_key $SecretAccessKey
aws configure --profile $AWS_PROFILE set aws_session_token $SessionToken

aws configure list --profile $AWS_PROFILE

echo "Expiration: $Expiration"
