{ pkgs }:
let
  project = "system-config";

  base = {
    packages = with pkgs; [
      just
    ];

    env = { };

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
builtins.mapAttrs
  (
    shellName: shell:
    let
      name = "${project} ${shellName}-shell";
      packages = pkgs.lib.unique (base.packages ++ (shell.packages or [ ]));
      shellHook = pkgs.lib.concatStringsSep "\n" [
        base.shellHook
        (shell.shellHook or "")
        ''echo "${name} activated."''
      ];
      env = base.env // shell.env;
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
    in
    pkgs.mkShell {
      inherit
        name
        packages
        env
        shellHook
        LD_LIBRARY_PATH
        ;
    }
  )
  (
    shells
    // {
      default = {
        packages = pkgs.lib.unique (
          pkgs.lib.flatten (map (shell: shell.packages or [ ]) (builtins.attrValues shells))
        );
        env = pkgs.lib.foldl' (acc: env: acc // env) { } (
          map (shell: shell.env or { }) (builtins.attrValues shells)
        );
        shellHook = pkgs.lib.concatStringsSep "\n" (
          map (shell: shell.shellHook or "") (builtins.attrValues shells)
        );
      };
    }
  )
