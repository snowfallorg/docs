---
title: Shells
description: Creating shells with Snowfall Lib.
---

To create a new shell, add a new directory your `shells` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `shells` directory for a new shell.
mkdir -p ./shells/my-shell
```

Now create the Nix file for the shell at `shells/my-shell/default.nix`.

```nix
{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # You also have access to your flake's inputs.
    inputs,

    # All other arguments come from NixPkgs. You can use `pkgs` to pull shells or helpers
    # programmatically or you may add the named attributes as arguments here.
    pkgs,
    stdenv,
    ...
}:

stdenv.mkDerivation {
    # Create your shell
}
```

This shell will be made available on your flake's `devShells` output with the same name as the
directory that you created.
