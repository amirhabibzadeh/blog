# وبلاگ امیر حبیب‌زاده

Source of my personal blog (Persian, RTL) — formerly WordPress on amirh.me (domain retired), now a static site built with [Hugo](https://gohugo.io) and hosted on GitHub Pages.

**Live:** https://amirhabibzadeh.github.io/blog/

## Write a post

```sh
hugo new content posts/my-post-slug.md   # creates a draft from archetypes/posts.md
hugo server                              # preview at http://localhost:1313 (drafts: add -D)
```

Edit the file, set `draft: false`, commit and push to `main`. GitHub Actions builds and deploys automatically.

- Categories: `personal` (شخصی), `experience` (تجربه), `public` (عمومی), `tutorial` (آموزش)
- Images: put them in `static/images/` and reference them as `/images/name.jpg`
- The post URL is `/<file name>/`, same as the old WordPress links

## Layout

| Path | What |
|------|------|
| `content/posts/` | Posts. Migrated ones are `.html` (original WordPress HTML), new ones are Markdown |
| `content/about.html` | About page |
| `data/comments/` | Archived WordPress comments (read-only), one JSON file per post ID |
| `layouts/` | Templates producing the same markup as WordPress's Twenty Nineteen theme |
| `static/css/` | Twenty Nineteen stylesheets + `site.css` additions |
| `static/wp-content/`, `static/virgool/` | Images migrated from WordPress and Virgool |
| `tools/fetch-giscus.sh` | Fetches the latest Giscus comments at build time |
| `.github/workflows/pages.yml` | Build and deploy to GitHub Pages |

## Comments

Archived comments are rendered from `data/comments/` (WordPress) and `data/virgool/` (from my Virgool copies of posts). New comments use [Giscus](https://giscus.app) (GitHub Discussions, "Announcements" category). The footer's "آخرین نظرات" mixes both: `tools/fetch-giscus.sh` pulls the latest Discussions comments at build time, and every new comment triggers a rebuild.

## Custom domain

The site builds against whatever URL GitHub Pages reports, so adding a custom domain in *Settings → Pages* needs no code change.
