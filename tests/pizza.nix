{ smithy4sGenerate, version }:

let pizzaSpec = builtins.fetchurl {
  url = "https://raw.githubusercontent.com/disneystreaming/smithy4s/v${version}/sampleSpecs/pizza.smithy";
  sha256 = "sha256:1b5vwahgvjr03a04xnx4lfr7ps4v7ncac7amvk1vwzhwx2m1jmpj";
};
in
smithy4sGenerate {
  pname = "pizza";
  inherit version;
  specs = [ pizzaSpec ];
}
