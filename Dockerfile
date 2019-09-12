FROM python:3.7-alpine
MAINTAINER EZ Turn

# recommended to run pyton in unbuffered mode in docker
ENV PYTHONUNBUFFERED 1

# copy local requirements.txt into vm /requirements.txt, then install
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# make /app directory on vm, cd into it and copy local ./app directory into vm /app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create new user named user.  -D means user gets no home directory
RUN adduser -D user
USER user
