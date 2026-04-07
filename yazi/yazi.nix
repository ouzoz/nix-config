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
          preview = { underline = false; };
          padding = { open = "▐"; close = "▌"; };
        };
        status = {
          sep_left = { open = "▐"; close = "▌"; };
          sep_right = { open = "▐"; close = "▌"; };
        };
        cmp = {
          icon_file = "🞍";
          icon_folder = "🗀";
          icon_command = "🞂";
        };
        icon = {
          dirs = [];
          files = [];
          exts = [];
          conds = [
            { "if" = "orphan"; text = ""; fg = "#ffffff"; }
            { "if" = "link"; text = "⯻"; fg = "red"; }
            { "if" = "block"; text = ""; fg = "#cddc39"; }
            { "if" = "char"; text = ""; fg = "#cddc39"; }
            { "if" = "fifo"; text = ""; fg = "#cddc39"; }
            { "if" = "sock"; text = ""; fg = "#cddc39"; }
            { "if" = "sticky"; text = ""; fg = "#cddc39"; }
            { "if" = "dummy"; text = ""; fg = "#f44336"; }

            { "if" = "dir"; text = "🗀"; }
            { "if" = "exec"; text = "🞂"; }
            { "if" = "!dir"; text = "🞍"; }
          ];
        };
      };
    };
  };
}
