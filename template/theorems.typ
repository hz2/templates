// custom theorem environments, the Typst equivalent of the tcolorbox
// environments in latex-template's preamble/theorems.tex. Each takes an
// optional title, e.g. #definition("Kerckhoffs's Principle")[...] or
// #definition[...] with no title.
#import "@preview/ctheorems:1.1.3": thmbox, thmproof, thmrules
#import "colors.typ": *

#let boxed(color) = thmbox.with(
  fill: color.lighten(85%),
  stroke: color,
  titlefmt: strong,
  separator: [#h(0.1em):#h(0.2em)],
  base: "heading",
  base_level: 1,
  radius: 3pt,
  inset: (x: 0.8em, y: 0.6em),
)

#let thm = boxed(light-purple)("thm", "Theorem")
#let definition = boxed(light-blue)("definition", "Definition")
#let example = boxed(light-red)("example", "Example")
#let remark = boxed(light-green)("remark", "Remark")
#let model = boxed(light-orange)("model", "Model")
#let lemma = boxed(light-teal)("lemma", "Lemma")

#let proof = thmproof("proof", "Proof")

// re-exported so a document only needs one `#show: thmrules` after
// importing this file
#let rules = thmrules
