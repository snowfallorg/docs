---
title: Packages
description: Creating packages with Snowfall Lib.
---

Snowfall Lib automatically exports your packages on your flake and makes them available to
all other parts of your flake. This includes making these packages available to other packages
in your flake, NixOS systems, Darwin systems, Home Manager, modules, and overlays.

To create a new package, add a new directory your `packages` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `packages` directory for a new package.
mkdir -p ./packages/my-package
```

Now create the Nix file for the package at `packages/my-package/default.nix`.

```nix
{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # You also have access to your flake's inputs.
    inputs,

    # All other arguments come from NixPkgs. You can use `pkgs` to pull packages or helpers
    # programmatically or you may add the named attributes as arguments here.
    pkgs,
    stdenv,
    ...
}:

stdenv.mkDerivation {
    # Create your package
}
```

This package will be made available on your flake's `packages` output with the same name as the
directory that you created.
