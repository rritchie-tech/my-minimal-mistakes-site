#!/bin/sh
set -e  # exit on any error

if [ "$MODE" = "dev" ]; then
  echo "Starting Jekyll in development mode..."
  exec bundle exec jekyll serve --host 0.0.0.0 --port 4000 --watch
else
  echo "Building and deploying Jekyll site..."
  bundle exec jekyll build --destination /srv/jekyll/_site

  # Configure git for deployment
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
  git remote set-url origin https://$GH_TOKEN@github.com/rritchie-tech/my-minimal-mistakes-site.git
  # Switch to gh-pages branch
  git checkout gh-pages || git checkout -b gh-pages

  # Replace old site with new build
  rm -rf * 
  cp -r _site/* .

  git add .
  git commit -m "Automated site build"
  git push origin gh-pages --force

  echo "Deployment complete!"
fi
