---
title: Quickstart
description: Get started with Snowfall Lib.
---

Snowfall Lib is a library that makes it easy to manage your Nix flake by imposing an
opinionated file structure.

## Create a flake if you don't have one already

Snowfall Lib generates your Nix flake outputs for you. If you don't already have a
Nix flake, you can create one using the following command.

```bash
# Create a flake in the current directory.
nix flake init
```

## Add Snowfall Lib to your flake

To start using Snowfall Lib, import the library in your Nix flake by adding it to your
flake's inputs.

```nix
{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

        # The name "snowfall-lib" is required due to how Snowfall Lib processes your
        # flake's inputs.
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # We will handle this in the next section.
    outputs = inputs: {};
}
```

## Create your flake outputs

```nix
{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
            # You must provide our flake inputs to Snowfall Lib.
            inherit inputs;

            # The `src` must be the root of the flake. See configuration
            # in the next section for information on how you can move your
            # Nix files to a separate directory.
            src = ./.;
        };
}
```

## Configure Snowfall Lib

Snowfall Lib offers some customization options. The following example details a few
popular settings. For a full list see [Snowfall Lib Reference](/docs/reference/lib).

```nix
{
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

            # Configure Snowfall Lib, all of these settings are optional.
            snowfall = {
                # Tell Snowfall Lib to look in the `./nix/` directory for your
                # Nix files.
                root = ./nix;

                # Choose a namespace to use for your flake's packages, library,
                # and overlays.
                namespace = "my-namespace";

                # Add flake metadata that can be processed by tools like Snowfall Frost.
                meta = {
                    # A slug to use in documentation when displaying things like file paths.
                    name = "my-awesome-flake";

                    # A title to show for your flake, typically the name.
                    title = "My Awesome Flake";
                };
            };
        };
}
```

Now that Snowfall Lib is set up in your Flake, you can begin adding Nix files!
From here, you can follow one of the other guides for Snowfall Lib like
[creating packages](/guides/lib/packages), [creating overlays](/guides/lib/overlays),
or [creating modules](/guides/lib/modules). You can also look at the [reference
documentation](/reference/lib) for Snowfall Lib for more technical information.
