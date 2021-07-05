(lang dune 2.0)
(name fidlib)

(generate_opam_files true)
(license "LGPL-2.1-or-later with OCaml-LGPL-linking-exception")
(authors "Michael Bacarella <m@bacarella.com>")
(maintainers "Michael Bacarella <m@bacarella.com>")
(homepage "https://github.com/mbacarella/fidlib")
(bug_reports "https://github.com/mbacarella/fidlib/issues")
(package
  (name fidlib)
  (synopsis "Run-time filter design and execution library")
  (description "OCaml bindings to fidlib")
  (depends
    (ocaml (>= 4.03))
    (dune (>= 2.0))
    base
    ctypes
    ctypes-foreign
  ))
