#import "feed.typ"
#import "page.typ" as page: make-page, meta

// Home page.
#make-page(
  meta(
    label: label("home"),
    output-path: "index.html",
    title: "Carl Kuhlemann",
    summary: "The personal website of Carl Kuhlemann.",
    author: "Carl Kuhlemann, John Doe",
    published: "2026-08-17",
    updated: "2026-08-18",
  ),
  title: "Home",
)[
  Finally, this site supports multiple files!
  Consider checking out the #link(<blog>)[blog].
  Also consider subscribing to the #link(<atom-feed>)[Atom feed]!

  Passed files:
  #for file in sys.inputs.files.split("\n") [
    - #raw(file)
  ]
]

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
  let label = label(label-path.replace("/", "."))
  // Used for article href in feed.
  let ref-path = output-path.trim("/index.html", at: end, repeat: false)

  // Retrieve and validate page metadata.
  import file: meta
  if meta != page.meta(..meta) {
    panic("must construct page metadata via `page.meta`: " + file)
  }
  meta = (
    :..meta,
    label: label,
    output-path: output-path,
    ref-path: ref-path,
  )

  // Output the actual page.
  make-page(meta, include file)
  pages.push(meta)
}
// Put most recent pages first.
#let pages = pages.sorted(by: (a, b) => a.published >= b.published)

// Blog overview page.
#make-page(
  meta(
    label: label("blog"),
    output-path: "blog/index.html",
    title: "Blog",
    summary: "Blog of Carl Kuhlemann.",
    published: "2026-08-17",
  ),
)[
  The following is a list of blog articles I've written:
  #for page in pages.filter(it => it.ref-path.starts-with("blog/")) [
    - *#link(page.label, page.title)*\
      #html.time(page.published.display("[month repr:short] [day], [year]"), datetime: page.published): #page.summary

  ]
]

// Generate feeds.
#asset(
  "blog/atom.xml",
  feed.atom(pages.filter(it => it.ref-path.starts-with("blog/"))),
) <atom-feed>

// The site icon.
#asset("favicon.png", read("favicon.png", encoding: none))
