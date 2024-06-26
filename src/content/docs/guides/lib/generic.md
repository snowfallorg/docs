---
title: Generic
description: Generic flake outputs when using Snowfall Lib.
---

Sometimes you want to put something on your flake output that isn't fully managed by
Snowfall Lib. See the following two sections for the best ways to handle generic flake
outputs.

## Outputs Builder

Snowfall Lib extends [flake-utils-plus](https://github.com/gytis-ivaskevicius/flake-utils-plus)
which means you can make use of `outputs-builder` to construct flake outputs for each
supported system.

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

            # The outputs builder receives an attribute set of your available NixPkgs channels.
            # These are every input that points to a NixPkgs instance (even forks). In this
            # case, the only channel available in this flake is `channels.nixpkgs`.
            outputs-builder = channels: {
                # Outputs in the outputs builder are transformed to support each system. This
                # entry will be turned into multiple different outputs like `formatter.x86_64-linux.*`.
                formatter = channels.nixpkgs.alejandra;
            };
        };
}
```

## Custom

If you can't use `outputs-builder` then it is also possible to merge your flake outputs with another
attribute set to provide custom entries.

:::warning
Merging in this way is destructive and will overwrite things generated by Snowfall Lib that share
the same names as the attributes you add.
:::

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
        # Generate outputs from Snowfall Lib.
        (inputs.snowfall-lib.mkFlake {
            inherit inputs;
            src = ./.;
        })
        # And merge some attributes with it.
        // {
            my-custom-output = "hello world";
        };
}
```
