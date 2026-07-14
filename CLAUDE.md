# mrbell.dev — resume + personal blog

Hugo site. Theme **minimal-black** (gitlab.com/jimchr12) as a **git submodule** in
`themes/` — it ships precompiled CSS, so there is **no Node build step** and the
system Hugo (0.164+) builds it fine. Default permalink is `/blog/<slug>/` (no dates).

## One repo, two Pages projects

This repo deploys to BOTH:
- **mrbell-dev** → `resume.mrbell.dev` (home = resume)
- **blog** → `blog.mrbell.dev` (a second build with `--baseURL blog.mrbell.dev` +
  a generated `public/_redirects` `/ /blog/ 301` so its home lands on the blog index)

**Deploy with `./deploy.sh`** — it builds and pushes both. Deploying only one leaves
`blog.mrbell.dev` stale.

## Content facts (don't re-guess these)

- Hero/about are framed around **AI SME / platform engineering** (see `~/web-dev/CLAUDE.md`).
- LinkedIn handle is **linkedin.com/in/mrbell90** — confirmed correct, not a placeholder.
- Blog posts use TOML frontmatter (`+++`) with `author = "Michael Bell"`.
