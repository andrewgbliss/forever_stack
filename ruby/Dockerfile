# Use Ruby 3.2 Alpine for smaller image size
FROM ruby:3.2-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
  postgresql-dev \
  build-base \
  tzdata \
  nodejs \
  yarn

# Copy Gemfile
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy application files
COPY . .

# Precompile assets (if using Rails)
RUN if [ -f "bin/rails" ]; then bundle exec rake assets:precompile; fi

# Expose port
EXPOSE 3001

# Start the application using Sinatra's built-in server
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0", "-p", "3001"]
