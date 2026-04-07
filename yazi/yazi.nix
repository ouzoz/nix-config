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
          # prepend_rules = [
          #   { name = "*/"; character = "🗀"; }
          #   { name = "*"; character = "🞍"; }
          # ];
          # prepend_dirs = [
          #   { name = "*"; text = "🗀"; }
          # ];
          prepend_conds = [
            { if = "dir"; text = "󰉋"; }
            { if = "!dir"; text = "󰈔"; }
          ];
        };
      };
    };
  };
}
