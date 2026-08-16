// native cetz diagram source (this is Typst code, so unlike figures/ipe/*.ipe
// it's not exported to an image -- it's imported and called directly).
// mirrors figures/ipe/example.ipe: two nodes connected by an arrow.
#import "@preview/cetz:0.5.2"
#import "/template/colors.typ": light-blue

#let example-diagram() = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  circle((0, 0), radius: 0.9, fill: light-blue, stroke: none, name: "e0")
  circle((5, 0), radius: 0.9, fill: light-blue, stroke: none, name: "e1")
  content("e0", text(white)[$e_0$])
  content("e1", text(white)[$e_1$])

  line((1, 0), (4, 0), mark: (end: "stealth"))
  content((2.5, 0.4), $D$)
})
