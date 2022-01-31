{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ (final: prev: { jre = final.openjdk11; }) ]; };
        coursier = pkgs.callPackage ./coursier.nix { };
        version = "0.11.3";
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

        lib = {
          smithy4sGenerate =
            { pname, version, specs }:
            let inherit (pkgs) stdenv; in

            stdenv.mkDerivation {
              pname = "smithy4s-${pname}";
              inherit version;

              dontUnpack = true;
              buildInputs = [ self.packages.${system}.codegen ];

              buildPhase = ''
                smithy4s-codegen generate \
                  --output $out/scala \
                  --openapi-output $out/openapi \
                  ${builtins.concatStringsSep " " specs}
              '';

              dontInstall = true;
            };
        };
      }
    );
}

