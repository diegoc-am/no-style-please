FROM ruby:slim

EXPOSE 4000

RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
    build-essential \
    git
RUN rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem install bundler

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve"]
