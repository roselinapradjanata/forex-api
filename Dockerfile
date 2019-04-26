FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /forex_api
WORKDIR /forex_api
COPY Gemfile /forex_api/Gemfile
COPY Gemfile.lock /forex_api/Gemfile.lock
RUN bundle install
COPY . /forex_api

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
