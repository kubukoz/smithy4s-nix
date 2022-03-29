{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ (final: prev: { jre = final.openjdk11; }) ]; };
        coursier = pkgs.callPackage ./coursier.nix { };
        version = "0.12.7";
      in
      {
        defaultPackage = self.packages.${system}.codegen;
        packages = {
          codegen = pkgs.callPackage ./derivation.nix {
            inherit (coursier) coursier-tools;
            inherit version;
          };
        };

        checks = self.packages.${system} // {
          pizza = pkgs.callPackage ./tests/pizza.nix {
            inherit (self.lib.${system}) smithy4sGenerate;
            inherit version;
          };
        };

        lib = pkgs.callPackage ./lib.nix { smithy4s-codegen = self.packages.${system}.codegen; };
      }
    );
}

