{ pkgs, ... }:

{
  nixpkgs.config.allowUnfreePackages = [ "apple_cursor" ];
  environment = {
    systemPackages = with pkgs; [ apple-cursor ];
    sessionVariables = {
      XCURSOR_THEME = "macOS";
      XCURSOR_SIZE = "20";
    };
  };
}
