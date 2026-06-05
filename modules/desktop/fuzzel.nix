{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  environment.etc."xdg/fuzzel/fuzzel.ini".source = (pkgs.formats.ini {}).generate "fuzzel.ini" {
    main = {
      font = "Oziosevka:size=12";
      line-height="18px";
      terminal = "foot";
      prompt = " ";
      icons-enabled = true;
      pad = "60x60";
      initial-color-theme = "dark";
      initial-window-size-chars = "12x50";
    };

    colors = {
      background = "000000db";
      text = "ffffff";
      selection = "232027";
    };

    border = {
      width = 0;
      radius = 12;
    };
  };
}
