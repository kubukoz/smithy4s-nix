{ smithy4sGenerate, version }:

let pizzaSpec = builtins.fetchurl {
  url = "https://raw.githubusercontent.com/disneystreaming/smithy4s/v${version}/sampleSpecs/pizza.smithy";
  sha256 = "sha256:0y0l407p56fp5bgzfaqbikd0xwaarx166drxmq1r758g6z3z7hys";
};
in
smithy4sGenerate {
  pname = "pizza";
  inherit version;
  specs = [ pizzaSpec ];
}
