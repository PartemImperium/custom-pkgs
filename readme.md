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
* [Changing fetcher isnt updating result](https://nixos.org/manual/nixpkgs/stable/#chap-pkgs-fetchers-caveats)

### Examples of various packaging techniques 

* [Multiple sources (whatcable)](pkgs/whatcable/default.nix)
* [FetchZip bin download](pkgs/whatbattery/default.nix)

## Flake input pinning

This repo contains a bunch of inputs used by other flakes and in actual nixos/home manager configs will set their inputs to follow the ones here. This allows for a consistent version across multiple hosts. It also allows for a central spot to run a bot to update packages in a systematic fassion keeping packages more updated.

For more info on following inputs from another flake see https://hugosum.com/blog/syncronizing-inputs-across-flakes#synchronizing-inputs-with-proxy-flake 

For an example with this flake see the below example

```nix
{
  inputs = {
    custompkgs.url = "github:PartemImperium/custom-pkgs/master";
    nixpkgs.follows = "custompkgs/nixpkgs-stable";
    home-manager.follows = "custompkgs/home-manager";
  };

  outputs = { self, custompkgs, nixpkgs, home-manager, }:
    {

    };
}
```

## TODO:

* Setup Asyar
  * Universal local search/ app launcher
  * https://github.com/Xoshbin/asyar
* Setup SoulSync
  * Tool to manage media metadata and suggest new media to obtain
  * https://github.com/Nezreka/SoulSync/blob/main/Dockerfile
  * Could be docker container at first to get it going faster
* nix-init
  * Tool to make nix packaging easier
  * https://github.com/nix-community/nix-init
* nurl
  * Tool to prefetch nix expressions to get the hash
  * https://github.com/nix-community/nurl
* mac app util
  * Nix tools for nix-darwin installs
  * https://github.com/hraban/mac-app-util
* srvos
  * nixos modules made for servers
  * https://github.com/nix-community/srvos
  * I dont plan on using it but looking through it for some ideas to add to my modules
* nix-melt
  * nix app that shows dependencies of flakes in a nice little tui
  * https://github.com/nix-community/nix-melt
* stylix
  * helper to style a bunch of stuff consistently in nix configs
  * https://github.com/nix-community/stylix
* raspberry-pi-nix
  * bunch of stuff to make working with nix and raspberry pi's easier
  * https://github.com/nix-community/raspberry-pi-nix
* import-tree
  * nix helper to make importing modules easier
  * https://github.com/denful/import-tree
* Skull King Tracket
  * Tracker for card game Skull King
  * Needs to be pacakged and make a module that serves the built js
  * https://github.com/avi-ss/Skull-King-Tracker
* Grist
  * Fancy spreadsheet with logic
  * kinda want to move a bunch of random stuff in here
  * https://www.youtube.com/watch?v=M3tqYJ9S_J8
  * https://github.com/gristlabs/grist-core
* usbeehive
  * linux tool to tell you what kind of cable is connected
  * needs to be packaged (maybe create a module as well)
  * https://github.com/abrauchli/usbeehive
* plymouth
  * boot animation app
  * Get it working with main computer 
    * attempted once and couldnt get it working fully (I think thats cause nvidia doesnt like it)
  * https://wiki.nixos.org/wiki/Plymouth
* direnv
  * dev environment tool for nix
  * https://www.youtube.com/watch?v=Oj9AxyiaVvU
  * https://devenv.sh/
* darktable
  * Virtual lighttable and darkroom for photographers
  * look into using
  * already packaged
* Look into universal clipboard manager (and share)
  * I have a couple ones I have found and want to look into
    * crosspaste
      * https://github.com/crosspaste/crosspaste-desktop
    * UniClipboard
      * https://github.com/UniClipboard/UniClipboard
* hidden bar
  * way to hide some menu bar icons
  * https://github.com/dwarvesf/hidden
* renovate
  * bot to updaate dependencies for you.
  * https://github.com/renovatebot/renovate
* deploy-rs
  * tool to help automatically update nix flakes on hosts
  * (not married to this tool but seems like it will solve the problem)
  * https://github.com/serokell/deploy-rs
  * https://www.youtube.com/watch?v=8gh4YXi_Cgk
* SearXNG
  * non google search engine. Maybe start using it?
  * https://www.youtube.com/watch?v=W9iV74uAd2Y
* https://www.youtube.com/watch?v=DnA4xNTrrqY
* Zen
  * new browser that isnt googlified...
  * https://zen-browser.app/
  * https://www.youtube.com/watch?v=PhVBCMPx4W4
