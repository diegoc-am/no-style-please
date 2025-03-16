FROM ruby:slim

EXPOSE 4000

RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
    build-essential \
    git
RUN rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem install bundler

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve"]
