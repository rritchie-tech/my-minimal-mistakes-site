FROM ruby:3.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    git \
 && rm -rf /var/lib/apt/lists/*

# Install Jekyll & Bundler
RUN gem install jekyll bundler

# Set working directory
WORKDIR /srv/jekyll

# Copy dependency files
COPY package.json ./
COPY Gemfile Gemfile.lock minimal-mistakes-jekyll.gemspec ./

# Install gems
RUN bundle install

# Copy the rest of the site files
COPY . .

# Copy the entrypoint script
COPY entrypoint.sh /srv/jekyll/entrypoint.sh
RUN chmod +x /srv/jekyll/entrypoint.sh

# Build argument to toggle dev/deploy
ARG MODE=dev
ENV MODE=${MODE}

# Run entrypoint
ENTRYPOINT ["/srv/jekyll/entrypoint.sh"]