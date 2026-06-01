{ pkgs }:
let
  name = "system-config";

  shellDefs = {
    nix = import ./nix.nix { inherit pkgs; };
    docs = import ./docs.nix { inherit pkgs; };
    lua = import ./lua.nix { inherit pkgs; };
    dev = import ./dev.nix { inherit pkgs; };
  };

  mkShellHook =
    shellName: shell:
    (shell.shellHook or "")
    + ''
      echo "- ${name} ${shellName}-shell activated."
    '';

  mkDevShell =
    shellName: shell:
    pkgs.mkShell {
      name = "${name}-${shellName}-shell";
      packages = shell.packages;
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath shell.packages;
      shellHook = mkShellHook shellName shell;
    };

  allPackages = pkgs.lib.unique (
    pkgs.lib.flatten (map (shell: shell.packages) (builtins.attrValues shellDefs))
  );
in
builtins.mapAttrs mkDevShell shellDefs
// {
  default = pkgs.mkShell {
    name = "${name}-default-shell";
    packages = allPackages;
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath allPackages;
    shellHook = ''
      echo "- ${name} default-shell activated."
    '';
  };
}
