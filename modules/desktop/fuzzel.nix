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
      prompt = "";
      icons-enabled = true;
      match-counter = true;
      terminal = "foot  -a '{cmd}' -T '{cmd}' {cmd}";
      list-executables-in-path = false;
      anchor = "top";
      y-margin = 12;
      lines = 12;
      minimal-lines = true;
      width = 42;
      horizontal-pad = 24;
      vertical-pad = 12;
      inner-pad = 6;
      image-size-ratio = 0.3;
      line-height="24";
    };

    colors = {
      background = "000000ea";
      text = "ffffffff";
      message = "ff0000ff";
      prompt = "ffffffff";
      placeholder = "ccccccff";
      input = "ffffffff";
      match = "00ff00ff";
      selection = "232027ff";
      selection-text = "ffffffff";
      selection-match = "ffffffff";
      counter = "0000ffff";
      border = "aaaaaaff";
    };

    border = {
      width = 0;
      radius = 12;
      selection-radius = 6;
    };
  };
}
