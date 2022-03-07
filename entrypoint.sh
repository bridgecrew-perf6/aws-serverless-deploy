#!/bin/bash

set -e

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is missing"
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is missing"
  exit 1
fi

if [ -z "$AWS_REGION" ]; then
  echo "AWS_REGION is missing"
  exit 1
fi

aws configure --profile aws-deploy-action <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

sh -c "npm install" \
&& sh -c "pip install -r requirements.txt" \
&& sh -c "SLS_DEBUG=1 serverless deploy"
SUCCESS=$?


echo "cleaning up aws deployment environment profile"
aws configure --profile aws-deploy-action <<-EOF > /dev/null 2>&1
null
null
null
text
EOF

if [ $SUCCESS -eq 0 ]
then
  echo "deployment success"
else
  echo "deployment fail"
  exit 1
fi
