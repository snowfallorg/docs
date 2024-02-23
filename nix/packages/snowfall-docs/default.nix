{
  lib,
  buildNpmPackage,
  nodePackages,
  nodejs,
  prisma-engines,
  buildGoModule,
  fetchFromGitHub,
  openssl,
  makeWrapper,
  gnused,
  snowfallorg,
  ...
}: let
  package-json = lib.importJSON (lib.snowfall.fs.get-file "package.json");
in
  buildNpmPackage {
    pname = "snowfall-docs";
    inherit (package-json) version;

    src = lib.snowfall.fs.get-file "/";

    nativeBuildInputs = [makeWrapper openssl];

    npmDepsHash = "sha256-thZLduBmcKEcVLeEGm58uUtbTzEW7CoNkdTnZ1nranE=";

    npmFlags = ["--ignore-scripts"];

    # NOTE: The version of esbuild must be synchronized between the binary pulled from
    # NixPkgs and the library from NPM.
    ESBUILD_BINARY_PATH = "${snowfallorg.esbuild-19_8}/bin/esbuild";

    installPhase = ''
      mkdir -p $out
      mv dist/* $out/
    '';
  }
