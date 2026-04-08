{ config, pkgs, ... }:

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
        set runtimepath^=/etc/nixos/modules/programs/nvim
        luafile /etc/nixos/modules/programs/nvim/init.lua
      '';
    };
  };
}
