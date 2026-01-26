#!/bin/bash
# Claude Code session startup hook for blog.andrewcantino.com

set -e

echo "Setting up Jekyll blog environment..."

# Install gems if Gemfile.lock is missing or outdated
if [ ! -f Gemfile.lock ] || [ Gemfile -nt Gemfile.lock ]; then
    echo "Installing/updating Ruby dependencies..."
    bundle install
fi

echo "Environment ready. Run 'bundle exec jekyll serve' to start dev server."
