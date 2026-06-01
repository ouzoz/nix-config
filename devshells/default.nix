{ pkgs }:
let
  name = "system-config";

  basePackages = with pkgs; [
    just
  ];
  baseShellHook = "";

  shellDefs = {
    nix = import ./nix.nix { inherit pkgs; };
    docs = import ./docs.nix { inherit pkgs; };
    lua = import ./lua.nix { inherit pkgs; };
  };

  shellDefs.default = {
    packages = pkgs.lib.unique (
      basePackages
      ++ pkgs.lib.flatten (map (shell: shell.packages or [ ]) (builtins.attrValues shellDefs))
    );

    shellHook = pkgs.lib.concatStringsSep "\n" [
      baseShellHook
      ''
        echo "- ${name} default-shell activated."
      ''
    ];
  };

  packagesFor = shell: pkgs.lib.unique (basePackages ++ (shell.packages or [ ]));
  shellHookFor =
    shellName: shell:
    pkgs.lib.concatStringsSep "\n" [
      baseShellHook
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
builtins.mapAttrs mkDevShell shellDefs
