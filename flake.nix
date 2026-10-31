{
  description = "Project templates";

  outputs = { self }: {
    templates = {
      default = self.templates.rust;
      rust = {
        path = ./rust;
        description = "Rust library: crane + rust-overlay, clippy, coverage, katex docs, release-plz";
        welcomeText = ''
          # rust template

          Rename the crate, then check (flakes only see git-tracked files):

              sh init.sh <crate-name> [github-owner]
              git init && git add -A
              nix flake check -L

          Then update the copyright holder in LICENSE-MIT and the
          description, keywords, and categories in Cargo.toml.
        '';
      };
      typst = {
        path = ./typst;
        description = "Typst paper and notes with Ipe and Cetz diagrams";
        welcomeText = ''
          # typst template

          Run `nix develop` for Typst, Ipe and PDF tools.

          Build the paper with `make build` and notes with `make notes`.
          See README.md for the project structure and diagram workflows.
        '';
      };
      latex = {
        path = ./latex;
        description = "LaTeX paper and notes with Ipe diagrams";
        welcomeText = ''
          # latex template

          Run `nix develop` for LaTeX, Ipe and PDF tools.

          Build the paper with `make build` and notes with `make notes`.
          See README.md for the project structure and diagram workflow.
        '';
      };
    };
  };
}
