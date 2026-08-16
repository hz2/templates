// generic helpers

// figure helper for an Ipe-exported diagram: name is the basename in
// figures/svg (no extension), width is a ratio like 70%
#let fig(width, name, caption) = figure(
  image("/figures/svg/" + name + ".svg", width: width),
  caption: caption,
)

#let code(x) = raw(x)
