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
    namespace, # The namespace used for your flake, defaulting to "internal" if not set.
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

Homes can have additional `specialArgs` and `modules` configured within your call to `mkFlake`.
See the following for an example which adds a Home Manager module to a specific host and sets a
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

            # Add modules to all homes.
            homes.modules = with inputs; [
                # my-input.homeModules.my-module
            ];

            # Add modules to a specific home.
            homes.users."my-user@my-host".modules = with inputs; [
                # my-input.homeModules.my-module
            ];

            # Add modules to a specific home.
            homes.users."my-user@my-host".specialArgs = {
                my-custom-value = "my-value";
            };
        };
}
```

## Options

For convenience, Snowfall Lib adds an additional set of configuration with context about
the current user. These values can be used to avoid having to hard code them or duplicate
the things that Snowfall Lib already knows about.

### `snowfallorg.user.enable`

This option determines whether the user's common, required options are automatically set.
The default value is `false` when used outside of Snowfall Lib, but is set to true when
you use a system or home created by Snowfall Lib.

Type: `Boolean`

Default: `false` (unless used in a system or home created by Snowfall Lib)

Example:

```nix
{
    snowfallorg.user.enable = true;
}
```

### `snowfallorg.user.name`

The name of the user. This value is provided to home-manager's `home.username` option during
automatic configuration. This option does not have a default value, but one is set automatically
by Snowfall Lib for each user. Most commonly this value can be accessed by other modules with
`config.snowfallorg.user.name` to get the current user's name;

Type: `String`

Example:

```nix
{
    snowfallorg.user.name = "my-user";
}
```

### `snowfallorg.user.home`

By default, the user's home directory will be calculated based on the platform and provided
username. However, this can still be customized if your user's home directory is in a
non-standard location.

Type: `String`

Default: `/home/${config.snowfallorg.user.name}` (Linux), `/Users/${config.snowfallorg.user.name}` (macOS)

Example:

```nix
{
    snowfallorg.user.home = "/mnt/home/my-user";
}
```
