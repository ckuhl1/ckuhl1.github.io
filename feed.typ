#let atom(pages) = {
  let template = ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <feed xmlns="http://www.w3.org/2005/Atom">
    <title type="html">ckuhl</title>
    <link rel="self" href="https://ckuhl.me/blog/atom.xml" type="application/atom+xml" />
    <link rel="alternate" href="https://ckuhl.me/blog" type="text/html" />
    <link rel="icon" href="favicon.png" type="image/svg+xml" />
    <updated>{UPDATED}</updated>
    <id>https://ckuhl.me/blog/atom.xml</id>
    <subtitle>TODO</subtitle>
    <author>
      <name>Carl Kuhlemann</name>
      <email>TODO</email>
      <uri>TODO</uri>
    </author>
    <icon>/favicon.png</icon>
  {ENTRIES}</feed>

  ```.text

  let entries = ""
  let last-updated = "0000-00-00"
  for page in pages {
    last-updated = calc.max(last-updated, page.updated)

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
      page.at(lower(m.captures.at(0)))
    })
    entries += entry
  }

  return template
    .replace("{UPDATED}", last-updated)
    .replace("{ENTRIES}", entries)
}
