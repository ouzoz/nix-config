{ inputs, pkgs, ... }:

let
  inherit (pkgs) lib;

  formatter = pkgs.callPackage ./formatter.nix { };
  fs = lib.fileset;
  src = fs.toSource {
    root = ./.;
    fileset = fs.difference ./. (fs.maybeMissing ./.git);
  };

  moduleFixture = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    system.stateVersion = lib.mkDefault "25.11";

    fileSystems."/" = {
      device = lib.mkDefault "/dev/null";
      fsType = lib.mkDefault "ext4";
    };

    boot.loader.grub = {
      enable = lib.mkDefault true;
      device = lib.mkDefault "nodev";
    };
  };

  moduleChecks = lib.mapAttrs' (
    name: module:
    lib.nameValuePair "nixos-module-${name}" (
      let
        evaluated = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            moduleFixture
            module
          ];
        };

        drvPath = builtins.addErrorContext "while evaluating nixosModules.${name} independently" evaluated.config.system.build.toplevel.drvPath;
      in
      builtins.seq drvPath (
        pkgs.runCommand "nixos-module-${name}-check" { } ''
          touch "$out"
        ''
      )
    )
  ) inputs.self.nixosModules;

in
{
  format = formatter.check src;

  statix = pkgs.runCommand "statix-check" { nativeBuildInputs = [ pkgs.statix ]; } ''
    cd ${src}
    statix check .
    touch $out
  '';
}
// lib.optionalAttrs (pkgs.stdenv.hostPlatform.system == "x86_64-linux") moduleChecks
