{ smithy4sGenerate, version }:

let pizzaSpec = builtins.fetchurl {
  url = "https://raw.githubusercontent.com/disneystreaming/smithy4s/v${version}/sampleSpecs/pizza.smithy";
  sha256 = "sha256:1m82wkll5wfr8f6m7hd4s3cs3f2zskzs8448hxs10d24wlspfg0w";
};
in
smithy4sGenerate {
  pname = "pizza";
  inherit version;
  specs = [ pizzaSpec ];
}
