FROM ruby:3.1.0

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install gem dependencies
COPY Gemfile* $APP_HOME/
RUN gem install bundler && bundle install

# Copy the rest of the application
COPY . $APP_HOME
