{ stdenv, smithy4s-codegen }:

let smithy4sGenerate =
  { pname, version, specs }:

  stdenv.mkDerivation {
    pname = "smithy4s-${pname}";
    inherit version;

    dontUnpack = true;
    buildInputs = [ smithy4s-codegen ];

    buildPhase = ''
      smithy4s-codegen generate \
        --output $out/scala \
        --openapi-output $out/openapi \
        ${builtins.concatStringsSep " " specs}
    '';

    dontInstall = true;
  };
in
{
  inherit smithy4sGenerate;
}
