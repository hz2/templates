#import "/template/layout.typ": layout
#import "/template/theorems.typ": rules, definition
#import "/template/macros.typ": fig

#show: layout
#show: rules

#align(center)[
  #text(17pt, weight: "bold")[Notes Title] \
  #v(0.5em)
  #text(11pt)[Jason Devers]
]

#v(1em)
#outline()
#pagebreak()

// a notes document is a single growing file -- add headings/content
// directly below as you go, rather than splitting into sections/*.typ
// like main.typ does.

= Topic

#definition("Term")[
  Definition text.
]

#fig(70%, "example", [An example diagram exported from `figures/ipe/example.ipe`])

#bibliography("references.bib")
