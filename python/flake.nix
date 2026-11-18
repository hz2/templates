{
  description = "A small Python app and CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      checks = forAllSystems (
        pkgs:
        let
          python = pkgs.python3.withPackages (ps: [ ps.pytest ]);
        in
        {
          default = pkgs.runCommand "python-check" {
            nativeBuildInputs = [
              python
              pkgs.ruff
            ];
            src = lib.cleanSource ./.;
          } ''
            cp -r "$src" project
            chmod -R u+w project
            cd project
            ruff check .
            ruff format --check .
            python -m pytest -q
            touch "$out"
          '';
        }
      );
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (ps: [ ps.pytest ]))
            pkgs.ruff
          ];
        };
      });
      formatter = forAllSystems (pkgs: pkgs.writeShellScriptBin "python-format" ''
        exec ${pkgs.ruff}/bin/ruff format "$@"
      '');
    };
}
