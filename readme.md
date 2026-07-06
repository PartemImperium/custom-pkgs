# Custom Nix Packages Flake

A accumulation of custom packages, nixos modules, home manager modules (and in the future nix-darwin modules) that nixpkgs does not have already.

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

### Helpful Docs for packaging a new app

* [Good Outline on Various Language Frameworks](https://ryantm.github.io/nixpkgs/languages-frameworks/index/#chap-language-support)

## Flake input pinning

This repo contains a bunch of inputs used by other flakes and in actual nixos/home manager configs will set their inputs to follow the ones here. This allows for a consistent version across multiple hosts. It also allows for a central spot to run a bot to update packages in a systematic fassion keeping packages more updated.

For more info on following inputs from another flake see https://hugosum.com/blog/syncronizing-inputs-across-flakes#synchronizing-inputs-with-proxy-flake 

For an example with this flake see the below example

```nix
{
  inputs = {
    custompkgs.url = "github:PartemImperium/custom-pkgs/master";
    nixpkgs.follows = "custompkgs/nixpkgs-stable";
    home-manager.follows = "custompkgs/home-manager"
  };

  outputs = { self, custompkgs, nixpkgs, home-manager, }:
    {

    };
}
```
