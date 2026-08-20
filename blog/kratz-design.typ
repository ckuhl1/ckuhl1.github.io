#import "../post.typ": meta
#let meta = meta(
  title: "Design notes on kratz",
  summary: "Some of the rationales I considered in designing the kratz programming language.",
  updated: "2026-08-17",
  published: "2026-08-15",
)

Compilation occurs in the following steps:
- *Lexing & parsing:*
  After this stage,
  each file is represented as one big list of `Node`s.
  The only statements we've already singled out at this point are
  those with a special syntax, i.e.,
  `add`, `del`, `if`/`else-if`/`else`, `repeat`, and `until` statements.
  Boundaries between individual scripts haven't been identified yet.

- *Transforming:*
  In this stage,
  we convert the abstract `Node`s into more specific `Block`s,
  each representing an actual Scratch block.
  To this end, we also convert built-in functions (`lerp`, `max`, ...)
  and statements (`swap`, ...)
  into their Scratch block expansions.
  We also desugar custom function calls used in expressions.

- *Evaluating:*
  This stage necessarily includes constant folding,
  followed by validation of field parameters
  as well as variables and custom blocks.
  At this point we can finally cut the `Block` list into individual scripts.
  We validate that the file starts with a hat block,
  and that cap blocks are always followed by hat blocks.
