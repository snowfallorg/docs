---
title: Channels
description: Using NixPkgs with Snowfall Lib.
---

Snowfall Lib makes use of a core package set to build systems, packages, and more. This package set
is taken from the input on your flake named `nixpkgs`. However, it is common to provide additional
configuration for NixPkgs before using it. In order to do this, you can use the `channels-config`
option.

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

            # The attribute set specified here will be passed directly to NixPkgs when
            # instantiating the package set.
            channels-config = {
                # Allow unfree packages.
                allowUnfree = true;

                # Allow certain insecure packages
                permittedInsecurePackages = [
                    "firefox-100.0.0"
                ];

                # Additional configuration for specific packages.
                config = {
                    # For example, enable smartcard support in Firefox.
                    firefox.smartcardSupport = true;
                };
            };
        };
}
```
