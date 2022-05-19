{ smithy4sGenerate, version }:

let pizzaSpec = builtins.fetchurl {
  url = "https://raw.githubusercontent.com/disneystreaming/smithy4s/v${version}/sampleSpecs/pizza.smithy";
  sha256 = "sha256:0hsl21qdwqqqkyhsqykgj5vkcn84v94rmkg70h5kcbf4vz9krs81";
};
in
smithy4sGenerate {
  pname = "pizza";
  inherit version;
  specs = [ pizzaSpec ];
}
