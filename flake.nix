{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ (final: prev: { jre = final.openjdk11; }) ]; };
        lib = pkgs.callPackage ./lib.nix { };
        version = "0.11.3";
      in
      {
        defaultPackage = self.packages.${system}.codegen;
        packages = {
          codegen = pkgs.callPackage ./derivation.nix {
            inherit (lib) coursier-tools;
            inherit version;
          };
        };

        checks = self.packages.${system} // {
          pizza = pkgs.callPackage ./tests/pizza.nix {
            smithy4s-codegen = self.packages.${system}.codegen;
            inherit version;
          };
        };

        inherit lib;
      }
    );
}

