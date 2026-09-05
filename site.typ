#import "feed.typ"
#import "linking.typ": *
#import "post.typ" as post: make-page, meta

// Home page.
#make-page(
  meta(
    label: <home>,
    output-path: "index.html",
    title: "Carl Kuhlemann",
    summary: "The personal website of Carl Kuhlemann.",
    author: "Carl Kuhlemann",
    published: "2026-08-17",
    updated: "2026-08-18",
  ),
  title: "Home",
)[
  This website is still in the making,
  but I've started work on my #link(<blog>)[blog], for instance.
  My current programming project is a programming language called `kratz`,
  which compiles to `.sb3` files
  for the #link("https://scratch.mit.edu")[Scratch] platform.
  The implementation is done in #link("https://gleam.run")[Gleam],
  to teach myself some functional programming.
  Don't expect much of it though,
  I (unfortunately) frequently switch projects.

  The HTML pages are authored in pure #link("https://typst.app")[Typst],
  with some Bash sprinkled in for the yet-unsupported features.
  You can find the source code
  #github("ckuhl1/ckuhl1.github.io")[here].
]

#let posts = ()
#for input-path in sys.inputs.posts.split("\n") {
  // Normalize file name to be used in output and by references.
  let base-path = input-path.replace(
    regex("^(?:\\./)?(.*?)\\.typ$"),
    m => m.captures.at(0),
  )
  // Used for labels in Typst code.
  let label-path = base-path.trim("/index", at: end, repeat: false)
  let label = label(label-path.replace("/", "."))
  // The output file's path.
  let output-path = label-path + "/index.html"
  // Used for explicit hrefs.
  let ref-path = output-path.replace(regex("/index.html"), "/")

  // Retrieve and validate post metadata.
  import input-path: meta
  if meta != post.meta(..meta) {
    panic("construct post metadata via `post.meta`: " + input-path)
  }
  meta = (
    :..meta,
    label: label,
    input-path: input-path,
    output-path: output-path,
    ref-path: ref-path,
  )

  // Output the actual pages.
  make-page(meta, include meta.input-path)
  posts.push(meta)
}
// Put most recent posts first.
#let posts = posts.sorted(by: (a, b) => a.published >= b.published)

// Blog overview page.
#make-page(
  meta(
    label: <blog>,
    output-path: "blog/index.html",
    ref-path: "blog/",
    title: "Blog",
    summary: "Blog of Carl Kuhlemann.",
    published: "2026-08-17",
  ),
)[
  I tend to write posts on programming, math, linguistics.
  There's also an #link(<atom-feed>)[Atom feed].
  #for post in posts.filter(it => it.ref-path.starts-with("blog/")) [
    - *#link(post.label, post.title)*\
      #html.time(post.published.display("[month repr:short] [day], [year]"), datetime: post.published): #post.summary

  ]
]

// Generate feeds.
#asset(
  "blog/atom.xml",
  feed.atom(posts.filter(it => it.ref-path.starts-with("blog/"))),
) <atom-feed>

// Remaining assets.
#asset("favicon.png", read("favicon.png", encoding: none))
#asset("favicon.svg", read("favicon.svg", encoding: none))
#asset("css/style.css", read("css/style.css", encoding: none))
#for font in sys.inputs.fonts.split("\n") {
  asset(font, read(font, encoding: none))
}
