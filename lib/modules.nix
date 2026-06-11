{ scanNixFiles, ... }:
{
  importsFrom = path: {
    imports = builtins.attrValues (scanNixFiles path);
  };

  enabledModule =
    optionPath: body:
    { config, lib, ... }:
    let
      pathParts =
        if builtins.isList optionPath then
          optionPath
        else if builtins.isString optionPath then
          lib.splitString "." optionPath
        else
          throw "enabledModule: optionPath must be a list or dot-separated string";

      enablePath = pathParts ++ [ "enable" ];
    in
    {
      options = lib.setAttrByPath enablePath (
        lib.mkEnableOption (builtins.concatStringsSep "." pathParts)
      );
      config = lib.mkIf (lib.attrByPath enablePath false config) body;
    };
}
