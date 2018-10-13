#!/bin/bash

set -e
stackname=lambci-gotgot
echo deleting stack
aws cloudformation delete-stack --stack-name $stackname
aws cloudformation wait stack-delete-complete --stack-name $stackname
echo creating stack
aws cloudformation create-stack --stack-name $stackname \
    --template-url https://lambci.s3.amazonaws.com/templates/lambci.template \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=GithubToken,ParameterValue=$1 \
    ParameterKey=Repositories,ParameterValue=gotgot \
    ParameterKey=SlackChannel,ParameterValue="#gotgot" \
    ParameterKey=SlackToken,ParameterValue=$2 \

aws cloudformation wait stack-create-complete --stack-name $stackname
echo created stack
npm install lambci-cli -g