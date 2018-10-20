#!/bin/bash

set -e
stackname=lambci-gotgot
echo deleting stack
aws cloudformation delete-stack --stack-name $stackname
aws cloudformation wait stack-delete-complete --stack-name $stackname
echo creating stack
aws cloudformation create-stack --stack-name $stackname
aws cloudformation create-change-set --stack-name $stackname \
    --change-set-name $stackname \
    --template-url https://lambci.s3.amazonaws.com/templates/template.yaml \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=GithubToken,ParameterValue=$1 \
    ParameterKey=Repositories,ParameterValue=leonyork/gotgot \
    ParameterKey=SlackChannel,ParameterValue="#gotgot" \
    ParameterKey=SlackToken,ParameterValue=$2
aws cloudformation execute-change-set --change-set-name $stackname
aws cloudformation wait execute-change-set --change-set-name $stackname
echo created stack
npm install lambci-cli -g