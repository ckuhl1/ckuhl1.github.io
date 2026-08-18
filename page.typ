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
  )
}

#let make-page(page, title: auto, body) = [
  // Make references to index files point to their respective folders.
  #show html.elem.where(tag: "a"): it => {
    let trimmed = it.attrs.href.trim("/index.html", at: end, repeat: false)
    if trimmed.len() < it.attrs.href.len() {
      html.a(href: trimmed, it.body)
    } else {
      it
    }
  }

  #document(
    page.output-path,
    title: page.title,
  )[
    #html.html(lang: "en")[
      #html.head[
        #html.meta(charset: "utf-8")
        #html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
        #html.title(page.title)
        #html.meta(name: "description", content: page.summary)
        #context for author in page.author [
          #html.meta(name: "author", content: author)
        ]
        #html.link(rel: "icon", type: "image/png", href: "https://ckuhl.me/favicon.png")
      ]
      #html.body[
        #std.title(if title != auto { title } else { page.title })
        #body
      ]
    ]
  ] #page.label
]
