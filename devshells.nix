{ pkgs }:
let
  name = "system-config";

  base = {
    packages = with pkgs; [
      just
    ];

    shellHook = "";
  };

  shells = {
    nix = {
      packages = with pkgs; [
        nixfmt
        treefmt
        nixd
      ];
    };

    docs = {
      packages = with pkgs; [
        zensical
      ];
    };

    lua = {
      packages = with pkgs; [
        lua-language-server
      ];
    };
  };
in
builtins.mapAttrs (
  shellName: shell:
  let
    packages = pkgs.lib.unique (base.Packages ++ (shell.packages or [ ]));
    shellHook = pkgs.lib.concatStringsSep "\n" [
      base.shellHook
      (shell.shellHook or "")
      ''
        echo "- ${name} ${shellName}-shell activated."
      ''
    ];
  in
  pkgs.mkShell {
    name = "${name}-${shellName}-shell";
    inherit packages shellHook;
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
  }
) (shells
// {
  default = {
    packages = pkgs.lib.unique (
      pkgs.lib.flatten (map (shell: shell.packages or [ ]) (builtins.attrValues shells))
    );

    shellHook = pkgs.lib.concatStringsSep "\n" (
      map (shell: shell.shellHook or "") (builtins.attrValues shells)
    );
  };
})
