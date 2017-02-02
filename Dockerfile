FROM ruby:2.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libmysqlclient-dev \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN gem update --system && gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

EXPOSE 3000
CMD ["bin/rails", "s"]
