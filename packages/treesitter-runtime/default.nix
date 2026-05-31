{
  lib,
  parsers,
  runCommand,
  vimPlugins,
}:

let
  getLang =
    pkg:
    let
      name = pkg.pname or (builtins.parseDrvName pkg.name).name;
      stripped = lib.removePrefix "tree-sitter-" name;
    in
    builtins.replaceStrings [ "-" ] [ "_" ] stripped;
in

runCommand "treesitter-runtime" { } ''
  mkdir -p $out/parser
  mkdir -p $out/queries
  ${lib.concatMapStrings (pkg: ''
    lang=${getLang pkg}
    ln -s ${pkg}/parser $out/parser/$lang.so

    if [ -d ${vimPlugins.nvim-treesitter.src}/runtime/queries/$lang ]; then
      ln -s ${vimPlugins.nvim-treesitter.src}/runtime/queries/$lang $out/queries/$lang
    fi
  '') parsers}
''
