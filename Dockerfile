FROM ruby:2.6.3

RUN apt-get update -qq \
 && apt-get install -y build-essential libpq-dev nodejs bash

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
COPY . $APP_HOME
WORKDIR $APP_HOME

Add Gemfile Gemfile.lock
ENV BUNDLE_PATH /box
