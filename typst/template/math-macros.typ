// optional domain notation pack (crypto / probability). not imported by
// default -- opt in per-document with:
//   #import "/template/math-macros.typ": *
//
// number sets (naturals, integers, rationals, reals, complex) don't need a
// macro here -- Typst's math mode already provides NN, ZZ, QQ, RR, CC
// built in.

#let Gen = math.op("Gen")
#let Enc = math.op("Enc")
#let Dec = math.op("Dec")
#let Adv = math.cal("A")
#let Sys = math.cal("S")
#let MsgSp = math.cal("M")
#let CtSp = math.cal("C")
#let KeySp = math.cal("K")
#let Pr = math.op("Pr")
#let poly = math.op("poly")
