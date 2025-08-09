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
        # config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
      };
    in
    {
      # nix build .#example
      # Custom packages to be shared or upstreamed.
      packages.${system} = pkgs.callPackage ./pkgs { };
    };
}
