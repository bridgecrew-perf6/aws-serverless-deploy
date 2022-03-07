FROM python

LABEL "com.github.actions.name"="aws-serverless-deploy"
LABEL "com.github.actions.description"="Deploy Lambda functions to AWS using Serverless framework"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

LABEL version="1.0.0"
LABEL maintainer="Mircea Preotu <mircea@incognicode.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update
RUN apt-get upgrade -y

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y gcc g++ make
RUN apt-get install -y nodejs

RUN apt install -y python3-pip
RUN pip3 install awscli
RUN npm install -g serverless

ENTRYPOINT ["/entrypoint.sh"]