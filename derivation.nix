{ coursier-tools, version }:
let
  pname = "smithy4s-codegen";
  inherit version;
  channel = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://disneystreaming.github.io/coursier.json";
    sha256 = "sha256:1wzv32gd653gdr45mmxrdpljcjyw4bii00c268hm35mxbnmlfid5";
  }));
in
coursier-tools.coursierBootstrap {
  inherit version pname;
  artifact = "com.disneystreaming.smithy4s::smithy4s-codegen-cli:${version}";
  inherit (channel.smithy4s) mainClass;
  sha256 = "sha256-mPwayfLdyD9c+8uGssma2pEoSeL/YvIXwxQvzUUdvnQ=";
}

