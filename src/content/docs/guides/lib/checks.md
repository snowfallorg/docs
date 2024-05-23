---
title: Checks
description: Creating checks with Snowfall Lib.
---

To create a new check, add a new directory your `checks` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `checks` directory for a new check.
mkdir -p ./checks/my-checks
```

Now create the Nix file for the check at `checks/my-check/default.nix`.

```nix
{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # You also have access to your flake's inputs.
    inputs,

    # The namespace used for your flake, defaulting to "internal" if not set.
    namespace,

    # All other arguments come from NixPkgs. You can use `pkgs` to pull checks or helpers
    # programmatically or you may add the named attributes as arguments here.
    pkgs,
    ...
}:

# Create your check
pkgs.runCommand "my-check" { src = ./.; } ''
    make test
```

This check will be made available on your flake's `checks` output with the same name as the
directory that you created.
