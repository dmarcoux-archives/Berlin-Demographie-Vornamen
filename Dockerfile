FROM ruby:2.2.0
MAINTAINER Dany Marcoux

RUN mkdir app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

COPY .rubocop.yml \
     Gemfile \
     Gemfile.lock \
     Rakefile \
     app.rb \
     config.ru \
     robots.txt \
     $APP_ROOT/

RUN bundle install --jobs 4

COPY db $APP_ROOT/db
COPY helpers $APP_ROOT/helpers
COPY models $APP_ROOT/models
COPY routes $APP_ROOT/routes
COPY spec $APP_ROOT/spec

CMD bash
