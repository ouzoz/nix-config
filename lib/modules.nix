{ lib, ... }:

let
  inherit (builtins) attrNames readDir pathExists;

  selectedEntries =
    { dir }:
    let
      entries = readDir dir;
      names = lib.sort builtins.lessThan (attrNames entries);
    in
    lib.flatten (
      map (
        name:
        let
          type = entries.${name};
        in
        if !(lib.hasPrefix "_" name) then
          [ ]
        else if
          type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
        then
          [
            {
              name = lib.removeSuffix ".nix" name;
              path = dir + "/${name}";
            }
          ]
        else if type == "directory" && pathExists (dir + "/${name}/default.nix") then
          [
            {
              inherit name;
              path = dir + "/${name}/default.nix";
            }
          ]
        else
          [ ]
      ) names
    );
in
{
  paths =
    { dir }:
    map (entry: entry.path) (selectedEntries {
      inherit dir;
    });

  act =
    {
      dir,
      act ? import,
      args ? { },
    }:
    lib.listToAttrs (
      map
        (entry: {
          inherit (entry) name;
          value = act entry.path args;
        })
        (selectedEntries {
          inherit dir;
        })
    );
}
