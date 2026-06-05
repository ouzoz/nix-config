{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  environment.etc."xdg/fuzzel/fuzzel.ini".source = (pkgs.formats.ini {}).generate "fuzzel.ini" {
    main = {
      font = "monospace:size=14";
      terminal = "foot";
      prompt = "";
      icons-enabled = true;
    };

    colors = {
      background = "282a36ff";
      text = "f8f8f2ff";
      selection = "44475aff";
    };

    border = {
      width = 1;
      radius = 12;
    };
  };
}
