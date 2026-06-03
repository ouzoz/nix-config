{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    apple-cursor
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "20";
  };
}
