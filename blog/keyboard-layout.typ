#import "../post.typ": *
#let meta = meta(
  title: "Keyboard layouts",
  published: "2026-08-27",
  previous: <blog.kratz-design>,
)

For a long time I used the German QWERTZ layout
with freehand typing for everything, including coding.
When I finally managed to learn touch-typing
in the summer of 2025,
I decided to go for #link("https://colemak.org/")[Colemak]
for a few reasons:

- It's more ergonomic, duh.

- It's the most-widely available alt keyboard layout,
  apart from Dvorak,
  which is said to not really be all that ergonomic though.
  There's also Colemak-DH, but I decided against it
  because it wasn't available on my phone's keyboard;
  I know, that probably shouldn't be of importance
  for a _touch-typing_ layout.
  Generally though, Colemak simply felt better.

  In addition, I believed the main improvement to lie in
  using an ergonomic layout (and touch-typing) _at all_.
  Especially because I also write a lot in German and a few other languages,
  using a layout with a few more points on an English-language corpus
  would have had even less of a practical impact.

- I had attempted touch-typing a few times prior,
  but old muscle memory kept creeping through.
  Using a largely different layout successfully
  prevented that from happening.

Over the months,
I changed the default X11 version in a few ways:
by moving the umlauts `ä`, `ö`, `ü` below their base vowels
(where X11 usually places `á`, `ó`, `ú`),
by adding more dead diacritics
(and shifting a bunch of them to more natural positions),
and by reodering some punctuation to what I found
more comfortable and logical.
Separately, I found #github("AndreaOrru/wlcape")[`wlcape`],
the Wayland equivalent of `xcape`,
which remaps Caps Lock to Escape when tapped and to Ctrl when held,
which makes Vim and Emacs more comfortable simultaneously!
I even started using Escape far more in general
through its more accessible position.

Roughly one year later,
I had garnered a bit of practical experience,
so I revisited the alt layout community
to find something more suitable for my typing habits:
My main pain point thus far had been the need
to reach for right alt every time I wanted an umlaut or `ß`.
I rediscovered the German-language
#link("https://neo-layout.org/")[Neo community],
which has spawned a few layouts optimized for both German and English,
which I had originally deemed unnecessary.
Even better, by providing four additional layers,
the Neo layouts make
punctuation, navigation, and various other special characters
far more accessible.
Both punctuation, the arrow keys, and numpad
all occupy the same keys as the standard letters.

After some evaluation,
I decided to go for the rather new
#link("https://neo-layout.org/Layouts/noted/")[Noted layout]\;
it was developed with quite an advanced optimizer
and further hand-tweaked;
you can read more about it on
the #link("https://dariogoetz.github.io/noted-layout/")[official website] and
#reddit("r/KeyboardLayouts/comments/15jpgfa/my_journey_ends_here_the_noted_layout/")[this Reddit post]\;
it's even included in up-to-date Linux distros!
(Maybe read those posts first,
otherwise some of the following might make little sense.)
I've been very happy with my decision for the past few months;
below are some of my main takeaways:

- The concept of switching to a third layer
  with Caps Lock and `"'`
  took some time to get used to,
  but it is far more comfortable than
  reaching far around your keyboard,
  especially with your right pinkie.
  Most English alt layouts tend to
  either keep punctuation in its QWERTY positions,
  or to shift it around without considering additional layers.
  Even within the Neo family,
  I'm not perfectly happy with the placement of
  some of the less-common punctuation,
  but the general idea of placing the paired delimiters
  `()`, `{}`, `<>`, and `[]` beneath the two strongest fingers
  (index and middle finger)
  is extremely relaxing.

  Specifically among the Neo layouts,
  on Noted the apostrophe shares its ring-finger position
  with `r`, instead of `n` or `t` like on many other layouts.
  This fortunate placement avoids many same-finger bigrams,
  while keeping the apostrophe accessible
  and in its original Neo position.

- Ergonomic placement of navigation keys
  belongs in the hands of one's keyboard layout,
  and not to any individual application like Vim.
  You need navigation keys in every situation,
  and expecting `hjkl` support from multiple applications
  (or switching to Vim for every line you write)
  is, in my opinion,
  a delegation of the problem rather than a treatment of the root cause.

  This was especially noticeable to me
  when I learned #link("https://helix-editor.com/")[Helix] using Colemak,
  and in the process wasn't able to use
  the recommended `hjkl` ways of navigation,
  incentivizing the development of more "unhealthy habbits".
  I attempted remapping to `neio`
  (the typical `hjkl`, shifted properly beneath the home position)
  or `unei`
  (QWERTY's `ijkl`, mimicking your typical arrow key configuration)
  instead,
  but that meant moving all the pretty mnemonic keys
  that had previously occupied those spots
  to other places.
  Doing so would have been required for every program
  with `hjkl` support,
  which, amongst other things, stopped me from using Hyprland.

- Staying close to QWERTY with regard to common shortcut keys
  (`z`, `x`, `c`, `v`, sometimes `q` and `w` as well)
  is somewhat contradictory for an ergonomic layout.
  I understand the idea of keeping muscle memory,
  but that has to be relearned anyway.
  Rather, as Noted does,
  the goal should be to
  keep those shortcut keys near the left (or right) hand,
  to enable the simultaneous use of shortcuts and a mouse (or numpad).

  One very satisfying coincidence is
  the adjacency of `z` and `y` in the top-left corner:
  Many programs use Ctrl-z for undo and
  Ctrl-Shift-z or Ctrl-y for redo,
  so now undo and redo are in a logical constellation,
  right next to each other!
  And just the other day I discovered a similar delight
  with `b`/`f` (used e.~g. in manpages for scrolling pagewise).

- For German, the Colemak layout has
  a few uncomfortable same-finger bigrams like "sc" and "eu"
  with the left and right middle fingers, respectively.
  The Noted layout has astonishingly many SFBs:
  Some (like "ea" on the left and "bt" and "gt" on the right index finger)
  still feel quick and efficient,
  but there's a lot of SFB action going on
  between the inner two columns ("aq", "dt", "eo"/"oe", "eq", "oa", "pt").
  This prompts the use of ergonomic alt-fingering,
  far more so than Colemak does, in my opinion.
  I'm not quite settled on the idea yet,
  though I've been attemping to consistently alt-finger
  "eo", at least.

  The ring-finger SFBs "sy" ("psych-", "system") and
  "rl" ("early", "world") are unfortunate,
  but you can't have everything.

In fact, I would even recommend the Noted layout
to pure English speakers:
It might be because of German's syllable complexity,
but I find typing English on the layout
more comfortable than German,
and also more comfortable than typing English on Colemak.
Admittedly, being the first proper ergo layout,
Colemak is already comparatively old.
But considering that Noted sacrifices
quite central positions for the German umlauts,
and only uses a 40~% English training corpus,
I think that's quite a tribute to its quality!

I also conclude that layering is far underused
by typical ergo layouts
(when they aren't optimized for tiny keyboards).
It provides extremely easy access to punctuation
(strictly easier to reach than on QWERTY),
other alphabets and/or typographic Unicode characters,
as well as numerals and navigation keys
(obviating the need for ergonomic, application-specific shortcuts).
That makes layered layouts highly suitable for actual everyday use,
instead of mere running text,
which I feel is often overlooked in the community.

I'm at 70 WPM in both German and English currently,
slightly below what I had with Colemak after one year;
my goal is to reach 80,
which is plenty for everyday tasks.
I'm still looking for a proper column-stagger keyboard though.
