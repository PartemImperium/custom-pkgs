# Custom Nix Packages Flake

A accumulation of custom packages that nix does not have already.

## Adding a new package 

* Create a new directory under `pkgs` with the name of the package.
* Create a `default.nix` file for the package expression.
* Add package to `pkgs/default.nix`.
* Profit!

### Testing your new package

Run the below command to build your new package named `testing-package`.

```sh
nix build .#testing-package
```

This will build the `testing-pacakge` in the `result` directory.