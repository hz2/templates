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
    };
  };
}
