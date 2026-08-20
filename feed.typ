#let atom(posts) = {
  let template = ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <feed xmlns="http://www.w3.org/2005/Atom">
    <title type="text">ckuhl</title>
    <link rel="self" href="https://ckuhl.me/blog/atom.xml" type="application/atom+xml" />
    <link rel="alternate" href="https://ckuhl.me/blog" type="text/html" />
    <updated>{UPDATED}T00:00:00.000Z</updated>
    <id>https://ckuhl.me/blog/atom.xml</id>
    <subtitle>TODO</subtitle>
    <author>
      <name>Carl Kuhlemann</name>
      <uri>https://ckuhl.me</uri>
    </author>
  {ENTRIES}</feed>

  ```.text

  let entries = ""
  let last-updated = datetime(year: 0, month: 1, day: 1)
  for post in posts {
    last-updated = calc.max(last-updated, post.updated)

    let entry = ```xml
      <entry>
        <title type="text">{TITLE}</title>
        <link href="https://ckuhl.me/{REF-PATH}" rel="alternate" type="text/html" title="{TITLE}" />
        <id>https://ckuhl.me/{REF-PATH}</id>
        <updated>{UPDATED}T00:00:00.000Z</updated>
        <published>{PUBLISHED}T00:00:00.000Z</published>
        <author>
          <name>{AUTHOR}</name>
        </author>
        <summary type="text">{SUMMARY}</summary>
        <content type="html" xml:base="https://ckuhl.me/{OUTPUT-PATH}"><![CDATA[%INCLUDE:site/{OUTPUT-PATH}%]]></content>
      </entry>

    ```.text
    entry = entry.replace(regex("\\{([-A-Z]+)\\}"), m => {
      let value = post.at(lower(m.captures.at(0)))
      if type(value) == array {
        value.join(", ")
      } else if type(value) == datetime {
        value.display()
      } else {
        value
      }
    })
    entries += entry
  }

  return template
    .replace("{UPDATED}", last-updated.display())
    .replace("{ENTRIES}", entries)
}
