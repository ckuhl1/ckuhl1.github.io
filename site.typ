#show html.elem.where(tag: "a"): it => {
  let trimmed = it.attrs.href.trim("/index.html", at: end, repeat: false)
  if trimmed.len() < it.attrs.href.len() {
    html.a(href: trimmed, it.body)
  } else {
    it
  }
}

#document("index.html", title: [Home -- ckuhl])[
  #title()
  Finally, this blog can support multiple files!
  Consider checking out the #link(<blog>)[blog].
] <home>

#document("blog/index.html", title: [Blog -- ckuhl])[
  #title()
  The following is a list of blog articles:
  - TODO ...
] <blog>
