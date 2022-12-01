{ coursier-tools, version }:
let
  pname = "smithy4s-codegen";
  channel = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://disneystreaming.github.io/coursier.json";
    sha256 = "1178ra6y1iqbq5c9ahp6022wm8zmk4h28r8rid6cs18yzzsixpxz";
  }));
in
coursier-tools.coursierBootstrap {
  inherit version pname;
  artifact = "com.disneystreaming.smithy4s::smithy4s-codegen-cli:${version}";
  inherit (channel.smithy4s) mainClass;
  sha256 = "sha256-nVziVcjBy6HezAlbvxyJ0y6U1L4Q6E0mcgxastybTpk";
}

