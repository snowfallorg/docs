---
title: Aliases
description: Aliasing outputs with Snowfall Lib.
---

It is common for flakes to provide a `default` package, shell, overlay, etc. However,
by default Snowfall Lib will only create exports matching your directory structure.
You can inform Snowfall Lib to create an alias export by setting `alias` in your call
to `mkFlake`. Aliasing does not affect the original export, but creates a new export.

```nix
{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
            inherit inputs;
            src = ./.;

            alias = {
                # Create an alias to export a default package.
                packages.default = "my-package";

                # Create an alias to export a default shell.
                shells.default = "my-shell";

                # Create an alias to export a default overlay.
                overlays.default = "my-overlay";

                # Create an alias to export a default template.
                templates.default = "my-template";

                # Create an alias to export a default NixOS module.
                modules.nixos.default = "my-nixos-module";

                # Create an alias to export a default Darwin module.
                modules.darwin.default = "my-nixos-module";

                # Create an alias to export a default Home module.
                modules.home.default = "my-nixos-module";
            };
        };
}
```
