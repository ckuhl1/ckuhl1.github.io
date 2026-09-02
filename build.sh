#!/bin/bash
# Top-level pages must be specified in site.typ explicitly; here we only collect
# any nested pages.
posts="$(find -mindepth 2 -name "*.typ")"
fonts="$(find ./font -type f)"
echo $posts
echo $fonts
# Locally, the executable should already be on the PATH, but on GitHub, it's
# only in the cwd.
PATH="$PATH:." typst compile \
  --features=bundle,html \
  --format=bundle \
  --input "posts=$posts" \
  --input "fonts=$fonts" \
  --pretty \
  site.typ

# Read the supplied template file and, on every line, replace the first
# occurrence of `%INCLUDE:path%` with the verbatim contents of `path`.
populate_template() {
  local template="$1"
  local output="$2"

  while IFS= read -r line; do
    if [[ $line =~ ^(.*?)%INCLUDE:(.*?)%(.*)$ ]]; then
      printf '%s' "${BASH_REMATCH[1]}"
      sed -n '/<main>/,/<\/main>/{/<\/\?main>/d;p;}' "${BASH_REMATCH[2]}"
      printf '%s\n' "${BASH_REMATCH[3]}"
    else
      printf '%s\n' "$line"
    fi
  done < "$template" > "$output"
}

# Populate the feed entries' contents.
mv site/blog/atom.xml site/blog/atom-template.xml
populate_template site/blog/atom-template.xml site/blog/atom.xml
rm site/blog/atom-template.xml
