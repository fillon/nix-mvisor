{
  # https://github.com/tenclass/mvisor
  description = "MVisor: A mini x86 hypervisor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # nix build .#mvisor
      packages.${system} = pkgs.callPackage ./pkgs { };
    };
}
