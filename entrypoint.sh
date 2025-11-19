#!/bin/sh
set -e  # exit on any error

if [ "$MODE" = "dev" ]; then
  echo "Starting Jekyll in development mode..."
  exec bundle exec jekyll serve --host 0.0.0.0 --port 4000 --watch
else
  echo "Building and deploying Jekyll site..."
  
  # Build the site
  bundle exec jekyll build --destination /srv/jekyll/_site

  # Configure git
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
  git remote set-url origin https://$GH_TOKEN@github.com/rritchie-tech/my-minimal-mistakes-site.git

  # Switch to gh-pages branch (create if it doesn't exist)
  git fetch origin gh-pages || true
  git checkout gh-pages || git checkout -b gh-pages

  # Clear old files and copy new build
  git rm -rf . >/dev/null 2>&1 || true
  cp -r _site/* .
  
  # Commit and force push
  git add .
  git commit -m "Automated site build" || echo "Nothing to commit"
  git push origin gh-pages --force

  echo "Deployment complete!"
fi
