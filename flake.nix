{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    let version = "0.13.0"; in

    flake-utils.lib.eachDefaultSystem
      (
        system:

        let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; }; in
        {
          packages =
            pkgs.smithy4s;

          checks = self.packages.${system} // {
            pizza = pkgs.callPackage ./tests/pizza.nix {
              inherit (self.lib.${system}) smithy4sGenerate;
              version = pkgs.smithy4s.codegen.version;
            };
          };

          lib = pkgs.callPackage ./lib.nix { smithy4s-codegen = self.packages.${system}.codegen; };
        }
      ) // {
      overlays.default = final: _:
        let coursier = final.callPackage ./coursier.nix { }; in
        {
          smithy4s = {
            codegen = final.callPackage ./derivation.nix {
              inherit (coursier) coursier-tools;
            };
          };
        };
    };
}

