{ config, lib, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      yazi = lib.importTOML ./yazi.toml;
      theme = lib.importTOML ./theme.toml;
    };
  };
}
