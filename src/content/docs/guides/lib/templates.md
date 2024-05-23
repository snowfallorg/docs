---
title: Templates
description: Creating templates with Snowfall Lib.
---

To create a new template, add a new directory your `templates` directory. This directory
will be used when the template is consumed by users of your flake.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `templates` directory for a new template.
mkdir -p ./templates/my-templates
```

Now place any files inside of your template that you would like to provide to users. Once
you are ready, it is also a good idea to update your flake to set descriptions for your
templates.

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

            templates = {
                my-template.description = "This is my template created with Snowfall Lib!";
            };
        };
}
```

This template will be made available on your flake's `templates` output with the same name as the
directory that you created.
