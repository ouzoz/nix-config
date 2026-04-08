{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    configure = {
      customRC = ''
        set runtimepath^=/etc/nixos/programs/nvim
        luafile /etc/nixos/programs/nvim/init.lua
      '';
    };
  };
}
