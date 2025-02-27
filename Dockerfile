# Use the official Ruby image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /vk_app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of your application code
COPY . .

# Precompile assets (if needed)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Copy the entrypoint script
COPY entrypoint.sh /usr/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/bin/entrypoint.sh

# Expose the port your app runs on
EXPOSE 3000

# Set the entrypoint
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
