FROM 1firma/aws-serverless-deploy

LABEL "com.github.actions.name"="aws-serverless-deploy"
LABEL "com.github.actions.description"="Deploy Lambda functions to AWS using Serverless framework"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

LABEL version="1.0.0"
LABEL maintainer="Mircea Preotu <mircea@incognicode.com>"

ENV PATH /github/workspace/node_modules/.bin:$PATH
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]