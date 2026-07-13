#!/usr/bin/env bash
# Deploys this site to BOTH Cloudflare Pages projects:
#   - mrbell-dev  -> resume.mrbell.dev   (home = resume)
#   - blog        -> blog.mrbell.dev     (home 301s to /blog/)
# Same content, two baseURLs. Run after any content change.
set -euo pipefail
cd "$(dirname "$0")"

echo "== resume.mrbell.dev =="
rm -rf public
hugo --gc --minify
npx --yes wrangler@4 pages deploy public --project-name mrbell-dev --branch main --commit-dirty=true

echo "== blog.mrbell.dev =="
rm -rf public
hugo --gc --minify --baseURL "https://blog.mrbell.dev/"
printf "/  /blog/  301\n" > public/_redirects   # home -> blog index (this deploy only)
npx --yes wrangler@4 pages deploy public --project-name blog --branch main --commit-dirty=true
