# Andrew's Blog

Jekyll-based personal blog deployed to AWS S3 with CloudFront.

## Tech Stack

- **Jekyll 4.4** static site generator
- **Ruby 3.3** (see `.ruby-version`)
- **Tale theme** for minimal styling
- **S3 + CloudFront** for hosting

## Quick Commands

```bash
# Install dependencies
bundle install

# Local development server (http://localhost:4000)
bundle exec jekyll serve

# Build site
bundle exec jekyll build

# Deploy to production
./deploy
```

## Project Structure

- `_posts/` - Blog posts in Markdown (100+ posts since 2008)
- `_layouts/` - Page templates
- `_includes/` - Reusable components
- `_sass/` - Stylesheets
- `images/` - Post images
- `_site/` - Generated output (gitignored)

## Writing Posts

Create new posts in `_posts/` with filename format: `YYYY-MM-DD-title.markdown`

Front matter template:
```yaml
---
layout: post
title: "Post Title"
---
```

Use `{% img /images/file.png %}` for images (octopress-image-tag plugin).

## Deployment

The `deploy` script builds and syncs to S3 with CloudFront cache invalidation.
Requires `s3cmd` configured with AWS credentials.
