{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  environment.etc."xdg/fuzzel/fuzzel.ini".source = (pkgs.formats.ini {}).generate "fuzzel.ini" {
    main = {
      font = "Oziosevka:size=12";
      use-bold = true;
      placeholder = "";
      prompt = " ";
      icons-enabled = true;
      match-counter = true;
      terminal = "foot  -a '{cmd}' -T '{cmd}' {cmd}";
      list-executables-in-path = false;
      anchor = "top";
      y-margin = 12;

      line-height="18";
      pad = "60x60";
      initial-color-theme = "dark";
      initial-window-size-chars = "12x50";
    };

    colors = {
      background = "000000ea";
      text = "ffffff";
      selection = "232027";
    };

    border = {
      width = 0;
      radius = 12;
    };
  };
}
