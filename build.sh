#!/bin/bash
# Top-level pages must be specified in site.typ explicitly; here we only collect
# any nested pages.
files="$(find -mindepth 2 -name "*.typ")"
echo $files
typst compile --features=bundle,html --format=bundle --pretty --input "files=$files" site.typ

# Read the supplied template file and, on every line, replace the first
# occurrence of `%INCLUDE:path%` with the verbatim contents of `path`.
populate_template() {
  local template="$1"
  local output="$2"

  while IFS= read -r line; do
    if [[ $line =~ ^(.*?)%INCLUDE:(.*?)%(.*)$ ]]; then
      printf '%s' "${BASH_REMATCH[1]}"
      cat "${BASH_REMATCH[2]}"
      printf '%s\n' "${BASH_REMATCH[3]}"
    else
      printf '%s\n' "$line"
    fi
  done < "$template" > "$output"
}

populate_template site/blog/atom-template.xml site/blog/atom.xml
# rm site/blog/atom-template.xml
