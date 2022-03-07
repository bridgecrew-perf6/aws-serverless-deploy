FROM python

LABEL "com.github.actions.name"="aws-serverless-deploy"
LABEL "com.github.actions.description"="Deploy Lambda functions to AWS using Serverless framework"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

LABEL version="1.0.0"
LABEL maintainer="Mircea Preotu <mircea@incognicode.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get install -y gcc g++ make nodejs python3-pip
RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli
RUN npm install -g serverless

ENV PATH /github/workspace/node_modules/.bin:$PATH
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]