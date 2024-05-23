---
title: Modules
description: Creating modules with Snowfall Lib.
---

Snowfall Lib automatically applies all of your modules to your systems. This means that
all NixOS modules will be imported for your NixOS systems, all Darwin modules will be
imported for your Darwin systems, and all Home Manager modules will be imported for your
Home configurations.

To create a new module, add a new directory to your `modules` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `modules/nixos`, `modules/darwin`, or `modules/home`
# directory for a new module.
mkdir -p ./modules/nixos/my-module
```

Now create the Nix file for the module at `modules/nixos/my-module/default.nix`.

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
    namespace, # The namespace used for your flake, defaulting to "internal" if not set.
    system, # The system architecture for this host (eg. `x86_64-linux`).
    target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
    format, # A normalized name for the system target (eg. `iso`).
    virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
    systems, # An attribute map of your defined hosts.

    # All other arguments come from the module system.
    config,
    ...
}:
{
    # Your configuration.
}
```

This module will be made available on your flake’s `nixosModules`, `darwinModules`,
or `homeModules` output with the same name as the directory that you created.
