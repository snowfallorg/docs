{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      outputs-builder = channels: {
        devShells = {
          default = channels.nixpkgs.mkShell {
            ESBUILD_BINARY_PATH = "${channels.nixpkgs.esbuild}/bin/esbuild";

            packages = with channels.nixpkgs; [
              esbuild
            ];
          };
        };

        packages = rec {
          default = snowfall-docs;

          # NOTE: This is currently broken due to esbuild complaining about a mismatched
          # binary version. This seems to be caused by vite specifying exactly version 0.18.20
          # regardless of what this package may require.
          # snowfall-docs = channels.nixpkgs.buildNpmPackage {
          #   pname = "snowfall-docs";
          #   src = ./.;
          #   version = inputs.self.sourceInfo.shortRev or "dirty";

          #   npmDepsHash = "sha256-sLKRNWwhRb9uyxJHC5xWC7PKl1nBj30RFgBm7m5dzgc=";

          #   npmFlags = ["--ignore-scripts" "--legacy-peer-deps"];

          #   ESBUILD_BINARY_PATH = "${channels.nixpkgs.esbuild}/bin/esbuild";

          #   installPhase = ''
          #     mv dist $out
          #   '';
          # };

          snowfall-docs = channels.nixpkgs.runCommandNoCC "snowfall-docs" {} ''
            cp -r ${./dist} $out
          '';
        };
      };
    };
}
