#!/bin/sh
set -e

if [ "$MODE" = "dev" ]; then
  echo "Starting Jekyll in development mode..."
  exec bundle exec jekyll serve --host 0.0.0.0 --port 4000 --watch
else
  echo "Building and deploying Jekyll site..."

  bundle exec jekyll build --destination /srv/jekyll/_site

  # Configure git for GitHub Actions
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
  git remote set-url origin https://$GH_TOKEN@github.com/<USERNAME>/<REPO>.git

  # Ensure gh-pages exists or create it
  git fetch origin gh-pages || true
  git checkout gh-pages || git checkout -b gh-pages

  # Overwrite with newly generated site
  git rm -rf . || true
  cp -r /srv/jekyll/_site/* .

  git add .
  git commit -m "Automated site build" || echo "Nothing to commit"

  git push origin gh-pages --force
  echo "Deployment complete!"
fi