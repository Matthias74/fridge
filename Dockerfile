ARG RUBY_VERSION=3.0.0
FROM ruby:$RUBY_VERSION-slim as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libmariadb-dev libpq-dev nodejs curl

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /docker/app

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD [ "bundle","exec", "puma", "config.ru"] # CMD ["rails","server"] # you can also write like this.