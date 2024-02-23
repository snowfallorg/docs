{
  mkShell,
  snowfallorg,
  ...
}:
mkShell {
  ESBUILD_BINARY_PATH = "${snowfallorg.esbuild-19_8}/bin/esbuild";
  packages = [
    snowfallorg.esbuild-19_8
  ];
}
