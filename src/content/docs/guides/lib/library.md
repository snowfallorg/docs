---
title: Library
description: Creating a Nix library with Snowfall Lib.
---

Snowfall Lib automatically passes your merged library to all other parts of your flake. This
means that you can access your own library with `lib.my-namespace` or any library from your
flake inputs with `lib.my-input`.

To create a library, add a new directory to your `lib` directory or use the base `lib` directory.

:::note
Remember to run `git add` when creating new files!
:::

```bash
# Create a directory in the `lib` directory for library methods that will be merged.
mkdir -p ./lib/my-lib
```

Now create the Nix file for the lib at `lib/my-lib/default.nix` (or `lib/default.nix`).

```nix
{
    # This is the merged library containing your namespaced library as well as all libraries from
    # your flake's inputs.
    lib,

    # Your flake inputs are also available.
    inputs,

    # Additionally, Snowfall Lib's own inputs are passed. You probably don't need to use this!
    snowfall-inputs,
}:
{
    # This will be available as `lib.my-namespace.my-helper-function`.
    my-helper-function = x: x;

    my-scope = {
        # This will be available as `lib.my-namespace.my-scope.my-scoped-helper-function`.
        my-scoped-helper-function = x: x;
    };
}
```

This library will be made available on your flake’s `lib` output.
