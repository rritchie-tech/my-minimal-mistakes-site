FROM ruby:3.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    git \
    bash \
 && rm -rf /var/lib/apt/lists/*


RUN gem install jekyll bundler

WORKDIR /srv/jekyll

# Copy dependency files
COPY package.json ./
COPY Gemfile Gemfile.lock minimal-mistakes-jekyll.gemspec ./

RUN bundle install

# Copy all repo files
COPY . .

# Build arg passed from docker or GitHub Actions
ARG MODE=deploy
ENV MODE=$MODE

# Run script
CMD ["/srv/jekyll/entrypoint.sh"]
