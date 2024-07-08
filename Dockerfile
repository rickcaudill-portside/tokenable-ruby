FROM ruby:3.2.2


RUN apt-get update -q
RUN mkdir /app

COPY . /app

RUN mkdir -p /app/tmp/pids
RUN chmod 666 /app/tmp/pids
RUN ls -all /app

WORKDIR /app
RUN bundle install
RUN cd /app/spec/dummy/ && RAILS_ENV=test bundle exec rails db:drop && RAILS_ENV=test bundle exec rails db:create && RAILS_ENV=test bundle exec rails db:migrate


ENTRYPOINT [ "bundle", "exec","rspec" ]