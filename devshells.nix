{ pkgs }:
let
  name = "system-config";

  base = {
    Packages = with pkgs; [
      just
    ];

    ShellHook = "";
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

  shells.default = {
    packages = pkgs.lib.unique (
      pkgs.lib.flatten (map (shell: shell.packages or [ ]) (builtins.attrValues shells))
    );

    shellHook = pkgs.lib.concatStringsSep "\n" (
      map (shell: shell.shellHook or "") (builtins.attrValues shells)
    );
  };

  packagesFor = shell: pkgs.lib.unique (base.Packages ++ (shell.packages or [ ]));
  shellHookFor =
    shellName: shell:
    pkgs.lib.concatStringsSep "\n" [
      base.shellHook
      (shell.shellHook or "")
      ''
        echo "- ${name} ${shellName}-shell activated."
      ''
    ];

  mkDevShell =
    shellName: shell:
    let
      packages = packagesFor shell;
    in
    pkgs.mkShell {
      name = "${name}-${shellName}-shell";
      inherit packages;
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
      shellHook = shellHookFor shellName shell;
    };
in
builtins.mapAttrs mkDevShell shells
