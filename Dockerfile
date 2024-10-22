FROM ruby:2.6-bullseye
COPY Gemfile Gemfile.lock act_as_api_client.gemspec .
RUN bundle install