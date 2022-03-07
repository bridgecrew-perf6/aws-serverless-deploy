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

if [ -f "package.json" ]; then
  sh -c "npm install"
fi

if [ -f "requirements.txt" ]; then
  sh -c "pip install -r requirements.txt"
fi

sh -c "SLS_DEBUG=1 serverless deploy"
SUCCESS=$?

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
