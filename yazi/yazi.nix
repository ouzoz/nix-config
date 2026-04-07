{ config, lib, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      yazi = {
        manager = {
          ratio = "[ 1, 3, 2 ]";
          sort_by = "extension";
          linemode = "mtime" # size
          show_hidden = true
          show_symlink = true
        };
      };
      theme = lib.importTOML ./theme.toml;
    };
  };
}
