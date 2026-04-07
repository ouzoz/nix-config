{ config, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      yazi = {
        mgr = {
          ratio = [
            1
              3
              2
          ];
          sort_by = "extension";
          linemode = "mtime"; # size
          show_hidden = true;
          show_symlink = true;
        };
      };
      theme = {
        indicator = {
          
          padding = { open = "▐"; close = "▌"; };
        };
      };
    };
  };
}
