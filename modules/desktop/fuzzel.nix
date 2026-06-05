{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  environment.etc."xdg/fuzzel/fuzzel.ini".source = (pkgs.formats.ini {}).generate "fuzzel.ini" {
    main = {
      font = "Oziosevka:size=18";
      terminal = "foot";
      prompt = " ";
      icons-enabled = true;
    };

    colors = {
      background = "000000db";
      text = "ffffff";
      selection = "44475aff";
    };

    border = {
      width = 0;
      radius = 12;
    };
  };
}
