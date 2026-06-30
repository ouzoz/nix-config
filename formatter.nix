{ pkgs, lib, ... }:

pkgs.treefmt.withConfig {
  settings = {
    tree-root-file = "flake.nix";
    verbose = 1;
    on-unmatched = "debug";

    formatter = {
      just = {
        command = lib.getExe (
          pkgs.writeShellApplication {
            name = "justfmt";
            runtimeInputs = [ pkgs.just ];
            text = "just --fmt";
          }
        );
        includes = [ "justfile" ];
      };

      stylua = {
        command = lib.getExe pkgs.stylua;
        includes = [ "*.lua" ];
        options = [
          "--indent-type=Spaces"
          "--indent-width=2"
          "--column-width=120"
          "--quote-style=ForceDouble"
          "--call-parentheses=None"
          "--collapse-simple-statement=Always"
          "--space-after-function-names=Definitions"
          "--preserve-block-newline-gaps=Never"
          "--verify"
        ];
      };

      prettier = {
        command = lib.getExe pkgs.prettier;
        includes = [ "*" ];
        excludes = [ "*.nix" ];
        options = [
          "--write"
          "--ignore-unknown"
          "--print-width=120"
          "--tab-width=2"
          "--semi=true"
          "--single-quote=false"
          "--trailing-comma=all"
        ];
      };

      nixf-diagnose = {
        command = lib.getExe pkgs.nixf-diagnose;
        includes = [ "*.nix" ];
        options = [ "--auto-fix" ];
        priority = -1;
      };

      nixfmt = {
        command = lib.getExe pkgs.nixfmt;
        includes = [ "*.nix" ];
        options = [ "--strict" ];
      };
    };
  };
}
