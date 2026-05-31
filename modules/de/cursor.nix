{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    apple-cursor
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "macOS-White";
    XCURSOR_SIZE = "20";
  };
}
