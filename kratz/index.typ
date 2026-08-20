#import "../post.typ": meta
#let meta = meta(
  title: "The kratz Programming Language",
  summary: "A small scripting language designed for and compiling to Scratch.",
  updated: "2026-08-17",
  published: "2026-08-15",
)

While I work on the implementation (and a highlighter),
here's some minimal sample code:

```kratz
def draw-text(text, x, y, scale, wrap-at)
pen-up
pen-size := $scale
$k := 1
$x := $x
$y := $y
repeat len($text)
  costume "#"
  costume $k of $text
  $i := 2
  $data := $char-data[costume(number)]
  if $k > 1 and $x + (1 of $data) * $scale > $wrap-at
    $x := $x
    $y -= 14 * $scale
  end
  until $i > len($data)
    if $i of $data = "/"
      pen-up
      $i += 1
    else
      $n := ($i of $data) & (($i + 1) of $data)
      go $x + $n mod 7 * $scale, $y + (floor($n / 7) - 3) * $scale
      pen-down
      $i += 2
    end
  end
  pen-up
  $k += 1
  $x += ((1 of $data) + 1) * $scale
end
```
