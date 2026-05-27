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
          linemode = "mtime";
          show_hidden = true;
          show_symlink = true;
        };
      };
      theme = {
        mgr = {
          cwd = {
            fg = "cyan";
          };
          find_keyword = {
            fg = "yellow";
            bold = true;
            italic = true;
            underline = true;
          };
          find_position = {
            fg = "magenta";
            bg = "reset";
            bold = true;
            italic = true;
          };
          symlink_target = {
            italic = true;
          };
          marker_copied = {
            fg = "lightgreen";
            bg = "lightgreen";
          };
          marker_cut = {
            fg = "lightred";
            bg = "lightred";
          };
          marker_marked = {
            fg = "lightcyan";
            bg = "lightcyan";
          };
          marker_selected = {
            fg = "lightyellow";
            bg = "lightyellow";
          };
          count_copied = {
            fg = "white";
            bg = "green";
          };
          count_cut = {
            fg = "white";
            bg = "red";
          };
          count_selected = {
            fg = "black";
            bg = "yellow";
          };
          border_symbol = "│";
          border_style = {
            fg = "darkgray";
          };
          syntect_theme = "";
        };
        mode = {
          normal_main = {
            bg = "blue";
            bold = true;
          };
          normal_alt = {
            fg = "blue";
            bg = "gray";
          };
          select_main = {
            bg = "red";
            bold = true;
          };
          select_alt = {
            fg = "red";
            bg = "gray";
          };
          unset_main = {
            bg = "red";
            bold = true;
          };
          unset_alt = {
            fg = "red";
            bg = "gray";
          };
        };
        indicator = {
          preview = {
            underline = false;
          };
          padding = {
            open = "▐";
            close = "▌";
          };
        };
        status = {
          overall = { };
          sep_left = {
            open = "▐";
            close = "▌";
          };
          sep_right = {
            open = "▐";
            close = "▌";
          };
        };
        cmp = {
          icon_file = "🞍";
          icon_folder = "🗀";
          icon_command = "🞂";
        };
        filetype = {
          rules = [
            {
              mime = "image/*";
              fg = "yellow";
            }
            {
              mime = "{audio;video}/*";
              fg = "magenta";
            }
            {
              mime = "application/{zip;rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
              fg = "red";
            }
            {
              mime = "application/{pdf;doc,rtf}";
              fg = "cyan";
            }
            {
              mime = "vfs/{absent;stale}";
              fg = "gray";
            }
            {
              url = "*";
              is = "orphan";
              bg = "red";
            }
            {
              url = "*";
              is = "exec";
              fg = "green";
            }
            {
              url = "*";
              is = "dummy";
              bg = "red";
            }
            {
              url = "*/";
              is = "dummy";
              bg = "red";
            }
            {
              url = "*/";
              fg = "blue";
            }
          ];
        };
        icon = {
          globs = [ ];
          dirs = [ ];
          files = [ ];
          exts = [ ];
          conds = [
            {
              "if" = "orphan";
              text = "";
              fg = "#ffffff";
            }
            {
              "if" = "link";
              text = "⯻";
              fg = "red";
            }
            {
              "if" = "block";
              text = "";
              fg = "#cddc39";
            }
            {
              "if" = "char";
              text = "";
              fg = "#cddc39";
            }
            {
              "if" = "fifo";
              text = "";
              fg = "#cddc39";
            }
            {
              "if" = "sock";
              text = "";
              fg = "#cddc39";
            }
            {
              "if" = "sticky";
              text = "";
              fg = "#cddc39";
            }
            {
              "if" = "dummy";
              text = "";
              fg = "#f44336";
            }
            {
              "if" = "dir";
              text = "🗀";
            }
            {
              "if" = "exec";
              text = "🞂";
            }
            {
              "if" = "!dir";
              text = "🞍";
            }
          ];
        };
      };
    };
  };
}
