let
  inherit (builtins)
    attrNames
    attrValues
    filter
    listToAttrs
    map
    pathExists
    readDir
    stringLength
    substring
    ;

  hasSuffix =
    suffix: value:
    let
      suffixLength = stringLength suffix;
      valueLength = stringLength value;
    in
    valueLength >= suffixLength && substring (valueLength - suffixLength) suffixLength value == suffix;

  removeSuffix = suffix: value: substring 0 (stringLength value - stringLength suffix) value;

  scanNixFiles =
    path:
    let
      entries = readDir path;
      names = attrNames entries;

      directFiles = filter (
        name: entries.${name} == "regular" && name != "default.nix" && hasSuffix ".nix" name
      ) names;
      childDefaults = filter (
        name: entries.${name} == "directory" && pathExists (path + "/${name}/default.nix")
      ) names;
    in
    listToAttrs (
      map (name: {
        name = removeSuffix ".nix" name;
        value = path + "/${name}";
      }) directFiles
      ++ map (name: {
        inherit name;
        value = path + "/${name}/default.nix";
      }) childDefaults
    );

  mapNixFiles = f: path: builtins.mapAttrs f (scanNixFiles path);

  importNixFiles = path: mapNixFiles (_name: file: import file) path;

  base = {
    inherit scanNixFiles mapNixFiles importNixFiles;
  };

  imported = mapNixFiles (_name: file: import file base) ./.;

  mergeAttrsets = builtins.foldl' (acc: value: acc // value) { };
in
base // mergeAttrsets (attrValues imported)
