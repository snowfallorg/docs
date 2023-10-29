---
title: Systems
description: Creating systems with Snowfall Lib.
---

To create a new system, add a new directory to your `systems` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `systems` directory for a new system. This should follow
# Snowfall Lib's required system target format to ensure that the correct architecture
# and output are used.
mkdir -p ./systems/x86_64-linux/my-system
```

Now create the Nix file for the system at `systems/x86_64-linux/my-system/default.nix`.

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
    system, # The system architecture for this host (eg. `x86_64-linux`).
    target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
    format, # A normalized name for the system target (eg. `iso`).
    virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
    systems, # An attribute map of your defined hosts.

    # All other arguments come from the system system.
    config,
    ...
}:
{
    # Your configuration.
}
```

This system will be made available on your flake’s `nixosConfigurations`, `darwinConfigurations`,
or one of Snowfall Lib's virtual `*Configurations` outputs with the same
name as the directory that you created.

Systems can have additional `specialArgs` and `modules` configured within your call to `mkFlake`.
See the following for an example which adds a NixOS module to a specific host and sets a
custom value in `specialArgs`.

```nix
{
	description = "My Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
        inputs.snowfall-lib.mkFlake {
            inherit inputs;
            src = ./.;

            # Add modules to all NixOS systems.
            systems.modules.nixos = with inputs; [
                # my-input.nixosModules.my-module
            ];

            # If you wanted to configure a Darwin (macOS) system.
            # systems.modules.darwin = with inputs; [
            #   my-input.darwinModules.my-module
            # ];

            # Add a module to a specific host.
            systems.hosts.my-host.modules = with inputs; [
                # my-input.nixosModules.my-module
            ];

            # Add a custom value to `specialArgs`.
            system.hosts.my-host.specialArgs = {
                my-custom-value = "my-value";
            };
        };
}
```
