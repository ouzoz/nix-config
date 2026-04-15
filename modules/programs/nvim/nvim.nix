{ config, pkgs, ... }:

let
  treesitter-runtime = import ./treesitter.nix { inherit pkgs; };
  base-config = ./.;
in
{
  environment.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    configure = {
      customRC = ''
        set runtimepath+=${treesitter-runtime}
        set runtimepath^=${base-config}
        luafile ${base-config}/init.lua
      '';
    };
  };
}
