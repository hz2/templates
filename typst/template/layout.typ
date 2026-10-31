// page/heading setup, applied to a whole document with `#show: layout`
#let layout(doc) = {
  set page(
    paper: "us-letter",
    margin: (top: 1in, bottom: 1in, left: 1.25in, right: 1.25in),
    numbering: "1",
  )
  set text(size: 11pt)
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")
  show link: underline

  doc
}
