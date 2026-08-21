#let make-date(date) = {
  if type(date) == str {
    // Date-level precision is good enough for us.
    let captures = date.match(regex("^(\\d{4})-(\\d{2})-(\\d{2})$")).captures.map(int)
    datetime(year: captures.at(0), month: captures.at(1), day: captures.at(2))
  } else {
    panic("cannot parse date: " + repr(date))
  }
}

#let meta(
  label: none,
  output-path: none,
  ref-path: none,
  title: none,
  summary: none,
  author: auto,
  published: none,
  updated: auto,
  previous: none,
  next: none,
  //category: ((:)),
  //contributor: (),
  //rights: none,
  //source: (:),
) = {
  if type(title) != str {
    panic("title must be str")
  }
  if summary == none {
    summary = "No summary."
  } else if type(summary) != str {
    panic("summary must be str")
  }
  if author == auto {
    author = ("Carl Kuhlemann",)
  } else if type(author) == str {
    author = (author,)
  } else if type(author) == array {
    for a in author {
      if type(a) != str {
        panic("author must be auto, str or array of str")
      }
    }
  } else {
    panic("author must be auto, str or array of str")
  }
  if type(published) != datetime {
    published = make-date(published)
  }
  if updated == auto {
    updated = published
  } else if type(updated) != datetime {
    updated = make-date(updated)
  }

  return (
    label: label,
    output-path: output-path,
    ref-path: ref-path,
    title: title,
    summary: summary,
    author: author,
    published: published,
    updated: updated,
    previous: previous,
    next: next,
  )
}

#let make-page(post, title: auto, body) = [
  // Make references to index files point to their respective directories,
  // keeping trailing slashes.
  #show html.elem.where(tag: "a"): it => {
    let trimmed = it.attrs.href
      .replace(regex("index\\.html$"), ".")
      .replace(regex("/\\.$"), "/")
      .replace(regex("^#$"), "")

    if trimmed.len() < it.attrs.href.len() {
      html.a(href: trimmed, it.body)
    } else {
      it
    }
  }

  #document(
    post.output-path,
    title: post.title,
  )[
    #html.html(lang: "en")[
      #html.head[
        #html.meta(charset: "utf-8")
        #html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
        #html.title(post.title)
        #html.meta(name: "description", content: post.summary)
        #for author in post.author [
          #html.meta(name: "author", content: author)
        ]

        // #html.link(rel: "canonical", href: "https://ckuhl.me" + post.ref-path)
        // #html.link(rel: "alternate", type: "application/atom+xml", href: "/blog/atom.xml", title: "Atom 1.0")
        #html.link(rel: "stylesheet", type: "text/css", href: "/style.css")

        #html.link(rel: "icon", type: "image/png", href: "/favicon.png", sizes: ((32, 32),))
        #html.link(rel: "icon", type: "image/svg+xml", href: "/favicon.svg")
      ]
      #html.body[
        #html.header[
          #link(<home>)[Home] -- #link(<blog>)[Blog]
        ]
      
        #html.main[
          #std.title(if title != auto { title } else { post.title })
          #body
        ]

        #divider()
        #context html.footer[
          #let previous = if post.previous != none { query(post.previous).first() }
          #let next = if post.next != none { query(post.next).first() }

          #table(
            columns: 2,
            [*Published*], post.published.display("[month repr:short] [day], [year]"),
            ..if post.updated != post.published { ([*Updated*], post.updated.display("[month repr:short] [day], [year]")) },
            ..if previous != none { ([*Previous*], link(post.previous, previous.title)) },
            ..if next != none { ([*Next*], link(post.next, next.title)) },
          )
        ]
      ]
    ]
  ] #post.label
]
