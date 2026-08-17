#import "feed.typ"

#show html.elem.where(tag: "a"): it => {
  let trimmed = it.attrs.href.trim("/index.html", at: end, repeat: false)
  if trimmed.len() < it.attrs.href.len() {
    html.a(href: trimmed, it.body)
  } else {
    it
  }
}

#let parse-date(date) = {
  if type(date) == datetime {
    date
  } else if type(date) == str {
    // Date-level precision is good enough for us.
    let captures = date.match(regex("^(\\d{4})-(\\d{2})-(\\d{2})$")).captures.map(int)
    datetime(year: captures.at(0), month: captures.at(1), day: captures.at(2))
  } else {
    panic("cannot parse date: " + repr(date))
  }
}

#document("index.html", title: [Home -- ckuhl])[
  #html.html[
    #html.head[
      #html.meta(charset: "utf-8")
      #html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      #html.title("Home")
      #html.link(rel: "icon", type: "image/png", href: "favicon.png")
      #html.meta(name: "authors", content: "Carl Kuhlemann")
    ]
    #html.body[
      #title()
      Finally, this site supports multiple files!
      Consider checking out the #link(<kratz>)[blog].
      Also consider subscribing to the #link(<atom-feed>)[Atom feed]!

      Passed files:
      #for file in sys.inputs.files.split("\n") [
        - #raw(file)
      ]
    ]
  ]
] <home>

#let pages = ()
#for file in sys.inputs.files.split("\n") {
  // Normalize file name to be used in output and by references.
  let base-path = file.replace(
    regex("^(?:\\./)?(.*?)\\.typ$"),
    m => m.captures.at(0),
  )
  // The output file's path.
  let output-path = base-path + ".html"
  // Used for labels in Typst code.
  let label-path = base-path.trim("/index", at: end, repeat: false)
  // Used for article href in feed.
  let ref-path = output-path.trim("/index.html", at: end, repeat: false)

  // Retrieve and validate page metadata.
  import file: meta
  for field in (
    "title",
    "author",
    "summary",
    "updated",
    "published",
  ) {
    if field not in meta {
      panic("missing meta field `" + field + "` for page `" + file + "`")
    }
  }

  // Output the actual page.
  let page = document(
    output-path,
    title: meta.title,
    author: meta.author,
    date: parse-date(meta.published),
  )[
    #title()
    #include file
  ]
  [#page #label(label-path.replace("/", "."))]

  pages.push((
    output-path: output-path,
    ref-path: ref-path,
    ..meta,
  ))
}

// Generate feeds.
#let pages = pages.sorted(by: (a, b) => a.published >= b.published)
#asset(
  "blog/atom-template.xml",
  feed.atom(pages.filter(it => it.ref-path.starts-with("blog/"))),
) <atom-feed>

// The site icon.
#asset("favicon.png", read("favicon.png", encoding: none))
