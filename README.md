# MVisor: A mini x86 hypervisor - NIX Package

https://github.com/tenclass/mvisor

## Add to your flake.nix

```nix
# flake.nix

{
    inputs = {
        #...
        nix-mvisor.url = "github:fillon/nix-mvisor";
        nix-mvisor.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, ...}@inputs
    #...
}
```

```nix
# modules/some-config.nix

{ pkgs, inputs, ... }:
...

users.users.albert = {
    packages = with pkgs; [
        inputs.nix-mvisor.packages.x86_64-linux.mvisor
        #...
    ];
};
```
