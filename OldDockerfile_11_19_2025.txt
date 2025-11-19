FROM ruby:3.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
 && rm -rf /var/lib/apt/lists/*

# Install Jekyll & Bundler
RUN gem install jekyll bundler

# Set the working directory
WORKDIR /srv/jekyll

# Copy dependency files
COPY package.json ./
COPY Gemfile Gemfile.lock minimal-mistakes-jekyll.gemspec ./

# Install gems
RUN bundle install

# Copy the rest of the site files
COPY . .

# Expose Jekyll’s default port
EXPOSE 4000

# Run Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--watch"]
