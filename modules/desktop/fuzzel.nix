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
      lines = 6;
      minimal-lines = true;
      width = 42;
      horizontal-pad = 36;
      vertical-pad = 12;
      inner-pad = 0;
      image-size-ratio = 0.3;
      line-height="30";
    };

    colors = {
      background = "000000ea";
      text = "ffffff";
      message = "ff0000";
      prompt = "ffffff";
      placeholder = "cccccc";
      input = "ffffff";
      match = "00ff00";
      selection = "232027";
      selection-text = "ffffff";
      selection-match = "ffffff";
      counter = "0000ff";
      border = "aaaaaa";
    };

    border = {
      width = 0;
      radius = 12;
      selection-radius = 6;
    };
  };
}
