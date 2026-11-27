#!/usr/bin/env bash
# Writes data/giscus.json: latest Giscus (GitHub Discussions) comments, for the footer's "recent comments".
# Runs in CI with GH_TOKEN; any failure leaves an empty list so the build never breaks on it.
set -uo pipefail
repo="${GITHUB_REPOSITORY:-amirhabibzadeh/blog}"
cat_id=$(sed -n 's/^ *categoryId = "\(.*\)"/\1/p' hugo.toml)
mkdir -p data
gh api graphql -F owner="${repo%/*}" -F name="${repo#*/}" -F cat="$cat_id" -f query='
query($owner:String!,$name:String!,$cat:ID!){repository(owner:$owner,name:$name){
  discussions(first:50,categoryId:$cat,orderBy:{field:UPDATED_AT,direction:DESC}){nodes{title
    comments(last:20){nodes{createdAt url isMinimized author{login url}
      replies(last:20){nodes{createdAt url isMinimized author{login url}}}}}}}}}' \
  --jq '[.data.repository.discussions.nodes[] | .title as $t | .comments.nodes[] | (., .replies.nodes[])
         | select(.isMinimized|not) | {path:$t, date:.createdAt, url:.url, author:(.author.login // "ghost"), authorUrl:(.author.url // "")}]' \
  > data/giscus.json 2>/dev/null || echo '[]' > data/giscus.json
echo "giscus comments: $(grep -o '"path"' data/giscus.json | wc -l)"
