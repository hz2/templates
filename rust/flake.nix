{
  description = "A short description of rust-template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    advisory-db = {
      url = "github:rustsec/advisory-db";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      crane,
      rust-overlay,
      advisory-db,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      # platforms this flake is built and checked on
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems =
        f:
        lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              overlays = [ rust-overlay.overlays.default ];
            }
          )
        );

      # rust-version may be "1.85"; rust-overlay wants "1.85.0"
      msrv =
        let
          v = (lib.importTOML ./Cargo.toml).package.rust-version;
        in
        if lib.length (lib.splitString "." v) == 2 then "${v}.0" else v;

      mkProject =
        pkgs:
        let
          craneLib = (crane.mkLib pkgs).overrideToolchain (
            p: p.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml
          );
          craneLibMsrv = (crane.mkLib pkgs).overrideToolchain (p: p.rust-bin.stable.${msrv}.minimal);

          src = lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              (craneLib.fileset.commonCargoSources ./.)
              ./katex-header.html
            ];
          };

          commonArgs = {
            inherit src;
            strictDeps = true;
          };

          cargoArtifacts = craneLib.buildDepsOnly commonArgs;

          package = craneLib.buildPackage (
            commonArgs
            // {
              inherit cargoArtifacts;
              # tests run in their own check
              doCheck = false;
            }
          );

          doc = craneLib.cargoDoc (
            commonArgs
            // {
              inherit cargoArtifacts;
              RUSTDOCFLAGS = "--deny warnings --html-in-header ${./katex-header.html}";
            }
          );

          coverage = craneLib.cargoLlvmCov (commonArgs // { inherit cargoArtifacts; });

          # runs a cargo command for its exit status only
          cargoCheckCmd =
            lib': name: cmd: extra:
            lib'.mkCargoDerivation (
              commonArgs
              // {
                inherit cargoArtifacts;
                pnameSuffix = "-${name}";
                buildPhaseCargoCommand = cmd;
                installPhaseCommand = "mkdir -p $out";
                doInstallCargoArtifacts = false;
              }
              // extra
            );
        in
        {
          packages = {
            default = package;
            inherit doc coverage;
          };

          checks = {
            inherit package doc coverage;

            test = craneLib.cargoTest (commonArgs // { inherit cargoArtifacts; });

            clippy = craneLib.cargoClippy (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets --all-features -- --deny warnings";
              }
            );

            fmt = craneLib.cargoFmt { inherit src; };

            toml-fmt = craneLib.taploFmt {
              src = lib.sources.sourceFilesBySuffices src [ ".toml" ];
            };

            deny = craneLib.cargoDeny { inherit src; };

            audit = craneLib.cargoAudit { inherit src advisory-db; };

            no-default-features =
              cargoCheckCmd craneLib "no-default-features" "cargo build --locked --lib --no-default-features"
                { };

            bench-smoke = cargoCheckCmd craneLib "bench-smoke" "cargo bench --locked -- --test" { };

            # only the library must build on the msrv; dev-deps may need newer
            msrv = cargoCheckCmd craneLibMsrv "msrv" "cargo check --locked --lib --all-features" {
              cargoArtifacts = null;
            };

            nixfmt = pkgs.runCommand "nixfmt-check" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
              nixfmt --check ${./flake.nix}
              touch $out
            '';
          };

          devShells.default = craneLib.devShell {
            inputsFrom = [ package ];
            packages = [
              pkgs.just
              pkgs.taplo
              pkgs.nixfmt
              pkgs.cargo-llvm-cov
              pkgs.cargo-deny
              pkgs.cargo-audit
              pkgs.cargo-semver-checks
              pkgs.cargo-machete
              pkgs.release-plz
            ];
          };

          formatter = pkgs.nixfmt-tree;
        };

      perSystem = forAllSystems mkProject;
      pick = attr: lib.mapAttrs (_: project: project.${attr}) perSystem;
    in
    {
      packages = pick "packages";
      checks = pick "checks";
      devShells = pick "devShells";
      formatter = pick "formatter";
    };
}
