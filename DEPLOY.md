# Deploy — mrbell.dev (Cloudflare Pages)

Static Hugo site, `minimal-black` theme as a git submodule (ships precompiled
CSS — no Node build step needed).

## One-time: connect to Cloudflare Pages

Cloudflare dashboard → **Workers & Pages** → **Create** → **Pages** →
**Connect to Git** → authorize the GitHub App for **mrbell-dev** → pick
**mrbell.dev**.

Build settings:

| Setting | Value |
|---|---|
| Framework preset | Hugo |
| Build command | `hugo --gc --minify` |
| Build output directory | `public` |
| Production branch | `main` |

Environment variables:

| Name | Value |
|---|---|
| `HUGO_VERSION` | `0.164.0` |

Submodules are cloned automatically by Pages (the theme is a public GitLab repo).

## Custom domain

Pages project → **Custom domains** → add `mrbell.dev` (and `www.mrbell.dev`).
Requires the `mrbell.dev` zone to be on Cloudflare DNS.

## Auto-deploy

Every push to `main` builds and deploys. PRs get preview deployments.
