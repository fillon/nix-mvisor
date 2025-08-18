{
  # https://github.com/tenclass/mvisor
  description = "MVisor: A mini x86 hypervisor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-virglrenderer.url = "github:nixos/nixpkgs/517501bcf14ae6ec47efd6a17dda0ca8e6d866f9";
    #   "github:nixos/nixpkgs/                  ff0dbd94265ac470dda06a657d5fe49de93b4599";

  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            pkgs-virglrenderer = import inputs.nixpkgs-virglrenderer {
              inherit system;
              overlays = [
                (final: prev: {
                  virglrenderer = prev.virglrenderer.overrideAttrs (oldAttrs: {
                    version = "0.10.4";

                    src = pkgs.fetchurl {
                      url = "https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/8df4cba170940dad9350a99900293adbcef39b6c/virglrenderer-8df4cba170940dad9350a99900293adbcef39b6c.tar.bz2";
                      # hash = "sha256-tC27yH95n+t3+JokYzYlOu3HM/fDx41BAxWEON7qWm0=";
                      # url = "https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/8df4cba170940dad9350a99900293adbcef39b6c";
                      # url = "gitlab:virgl/virglrenderer/8df4cba170940dad9350a99900293adbcef39b6c";
                      # hash = "sha256-a+1EO7xQnGrEy+pKEMezWO9K4VZW+oCK5KzjkBTOR9Y=";
                      hash = "sha256-s4wIPiBJmaAtMWkr8SKufJ1/Et1nf3IvRA2/b6yuUr0=";
                    };
                    # src = pkgs.fetchFromGitLab {
                    #   owner = "virgl";
                    #   repo = "virglrenderer";
                    #   rev = "8df4cba170940dad9350a99900293adbcef39b6c";
                    # };
                  });
                })
              ];
            };
          })
        ];
      };
    in
    {
      # nix build .#mvisor
      packages.${system}.mvisor = pkgs.callPackage ./pkgs/mvisor { };
    };
}
