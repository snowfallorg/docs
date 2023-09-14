---
title: Homes
description: Creating homes with Snowfall Lib.
---

To create a new home, add a new directory to your `homes` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `homes` directory for a new home. This should follow
# Snowfall Lib's required home target format to ensure that the correct architecture
# and output are used.
mkdir -p ./homes/x86_64-linux/user@my-home
```

Now create the Nix file for the home at `homes/x86_64-linux/user@my-home/default.nix`.

```nix
{
    # Snowfall Lib provides a customized `lib` instance with access to your flake's library
    # as well as the libraries available from your flake's inputs.
    lib,
    # An instance of `pkgs` with your overlays and packages applied is also available.
    pkgs,
    # You also have access to your flake's inputs.
    inputs,

    # Additional metadata is provided by Snowfall Lib.
    home, # The home architecture for this host (eg. `x86_64-linux`).
    target, # The Snowfall Lib target for this home (eg. `x86_64-home`).
    format, # A normalized name for the home target (eg. `home`).
    virtual, # A boolean to determine whether this home is a virtual target using nixos-generators.
    host, # The host name for this home.

    # All other arguments come from the home home.
    config,
    ...
}:
{
    # Your configuration.
}
```

This home will be made available on your flake’s `homeConfigurations` output with the same
name as the directory that you created.
