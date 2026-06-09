let
  inherit (builtins)
    attrNames
    attrValues
    filter
    isList
    isString
    listToAttrs
    map
    mapAttrs
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

  discoveredFiles =
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
in
rec {
  scanNixFiles = discoveredFiles;

  mkImports = path: {
    imports = attrValues (scanNixFiles path);
  };

  mkEnableModules =
    optionPath: path:
    {
      config,
      lib,
      ...
    }@args:
    let
      files = scanNixFiles path;
      names = attrNames files;
      pathParts =
        if isList optionPath then
          optionPath
        else if isString optionPath then
          lib.splitString "." optionPath
        else
          throw "mkEnableModules: optionPath must be a list or dot-separated string";

      enablePath =
        name:
        pathParts
        ++ [
          name
          "enable"
        ];
      enabled = name: lib.attrByPath (enablePath name) false config;

      generatedOptions = lib.foldl' lib.recursiveUpdate { } (
        map (name: lib.setAttrByPath (enablePath name) (lib.mkEnableOption name)) names
      );

      evalModule =
        file:
        let
          imported = import file;
        in
        if builtins.isFunction imported then
          imported (args // { pkgs = config.nixpkgs.pkgs; })
        else
          imported;

      moduleConfig =
        name:
        let
          module = evalModule files.${name};
        in
        if module ? config then
          module.config
        else
          removeAttrs module [
            "config"
            "imports"
            "options"
            "_module"
          ];
    in
    {
      options = generatedOptions;
      config = lib.mkMerge (map (name: lib.mkIf (enabled name) (moduleConfig name)) names);
    };

  mkPackages = pkgs: path: mapAttrs (_name: file: pkgs.callPackage file { }) (scanNixFiles path);
}
