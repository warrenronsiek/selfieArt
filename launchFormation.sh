#!/usr/bin/env bash

aws s3 mb s3://$1 --region us-east-1
aws s3 cp $2.yaml s3://$1/$2.yaml
aws cloudformation create-stack --stack-name $2 --region us-east-1 --template-url 'https://s3-us-east-1.amazonaws.com/$1/$2.yaml' --capabilities 'CAPABILITY_IAM'
