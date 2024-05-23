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
    namespace, # The namespace used for your flake, defaulting to "internal" if not set.
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
            systems.hosts.my-host.specialArgs = {
                my-custom-value = "my-value";
            };
        };
}
```

## Options

When creating systems using Snowfall Lib, an additional module is added to your configuration
that allows for better integration of the library and its feature set. The following options
can be used in your NixOS or Darwin configurations and modules.

### `snowfallorg.users.<name>`

This option allows for the configuration of different users that have been specified using
Snowfall Lib's `homes/` directory.

Type: `Attribute Set`

Example:

```nix
{
    snowfallorg.users.my-user = {
        create = true;
        admin = false;

        home = {
            enable = true;
            path = "/mnt/home/my-user";

            config = {};
        };
    };
}
```

### `snowfallorg.users.<name>.create`

By default, Snowfall Lib will configure your system's `users.users` option to match the users
declared in `homes/`. This means that users will be automatically created for each home entry
available. If you do not want to create a user automatically, this value can be set to `false`.

Type: `Boolean`

Default: `true`

Example:

```nix
{
    snowfallorg.users.my-user = {
        create = false;
    };
}
```

### `snowfallorg.users.<name>.admin`

This option determines whether the user is automatically added to the wheel (linux) or admin
(macOS) group to enable `sudo` privileges. You probably want to enable this for at least one
user, but other users may not require this level of access.

Type: `Boolean`

Default: `true`

Example:

```nix
{
    snowfallorg.users.my-user = {
        admin = false;
    };
}
```

### `snowfallorg.users.<name>.home.enable`

Snowfall Lib defaults to integrating home-manager for each user. This includes the setting of
`home-manager.users.<name>` and providing any existing home modules for use. If you do not want
home-manager enabled for a specific user by default, then this setting can be turned off.

Type: `Boolean`

Default: `true`

Example:

```nix
{
    snowfallorg.users.my-user = {
        home = {
            enable = false;
        };
    };
}
```

### `snowfallorg.users.<name>.home.path`

This option allows for the customization of the home directory for a user. By default, it will
match the platform's typical location. For Linux this defaults to `/home/<name>` and for macOS
this is `/Users/<name>`. This value only needs to be changed if your user's home is in a
non-standard location such as a separate drive that is not mounted to `/home`.

Type: `String`

Default: `/home/<name>` (Linux), `/Users/<name>` (macOS)

Example:

```nix
{
    snowfallorg.users.my-user = {
        home = {
            path = "/mnt/home/my-user";
        };
    };
}
```

### `snowfallorg.users.<name>.home.config`

Due to Snowfall Lib's management of home-manager, in order to set configuration options for
home-manager within your system configuration you must use this option instead of
`home-manager.users.<name>`. The values provided are passed directly to home-manager for the
given user.

Type: `Attribute Set`

Default: `{}`

Example:

```nix
{
    snowfallorg.users.my-user = {
        home = {
            config = {
                # Everything in here is home-manager configuration.
                gtk.theme.package = pkgs.gnome.gnome-themes-extra;

                home.packages = with pkgs; [
                    my-package
                ];
            };
        };
    };
}
```
