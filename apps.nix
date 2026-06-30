{ pkgs, ... }:

{
  pkg-size = {
    type = "app";
    meta.description = "Inspect current system closure size with nix-tree";
    program =
      let
        script = pkgs.writeShellApplication {
          name = "system-size";
          runtimeInputs = [ pkgs.nix-tree ];
          text = ''
            nix-tree /run/current-system
          '';
        };
      in
      "${script}/bin/system-size";
  };
}
