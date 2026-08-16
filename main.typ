#import "/template/layout.typ": layout
#import "/template/theorems.typ": rules

#show: layout
#show: rules

#align(center)[
  #text(17pt, weight: "bold")[Paper Title] \
  #v(0.5em)
  #text(11pt)[Jason Devers]
]

#v(1em)

#align(center)[
  #block(width: 80%)[
    *Abstract* \
    One-paragraph summary of the paper: the problem, the approach, and the
    result.
  ]
]

#v(1em)
#outline()
#pagebreak()

#include "/sections/01-introduction.typ"
#include "/sections/99-appendix.typ"

#bibliography("references.bib")
