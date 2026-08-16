#import "/template/theorems.typ": definition, remark
#import "/template/macros.typ": fig
#import "/figures/cetz/example.typ": example-diagram

= Introduction <introduction>

Start writing here. A worked example of the theorem environments and both
figure pipelines (Ipe and cetz) follows, for reference.

#definition("Kerckhoffs's Principle")[
  A cryptosystem should be secure even if everything about the system,
  except the key, is public knowledge.
]

This template ships two example diagrams: one authored in Ipe and exported
to svg, and one drawn natively with cetz -- see @fig-ipe and @fig-cetz.

#fig(70%, "example", [An example diagram exported from `figures/ipe/example.ipe`]) <fig-ipe>

#figure(
  example-diagram(),
  caption: [The same idea, drawn natively with cetz (`figures/cetz/example.typ`)],
) <fig-cetz>

#remark("Citing sources")[
  References live in `references.bib` and are cited the usual way, e.g.
  @example2024.
]
