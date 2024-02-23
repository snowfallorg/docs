{
  lib,
  buildGoModule,
  fetchFromGitHub,
}: let
  pname = "esbuild";
  version = "0.19.8";
in
  buildGoModule rec {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "evanw";
      repo = "esbuild";
      rev = "v${version}";
      sha256 = "sha256-f13YbgHFQk71g7twwQ2nSOGA0RG0YYM01opv6txRMuw=";
    };

    vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";

    subPackages = ["cmd/esbuild"];

    ldflags = ["-s" "-w"];

    meta = with lib; {
      description = "An extremely fast JavaScript bundler";
      homepage = "https://esbuild.github.io";
      changelog = "https://github.com/evanw/esbuild/blob/v${version}/CHANGELOG.md";
      license = licenses.mit;
      maintainers = with maintainers; [jakehamilton];
      mainProgram = "esbuild";
    };
  }
