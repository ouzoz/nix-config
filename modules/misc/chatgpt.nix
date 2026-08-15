{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.my.misc;
in
{
  options.my.misc.chatgpt.enable = lib.mkEnableOption "chatgpt desktop app";

  config = lib.mkIf cfg.chatgpt.enable { environment.systemPackages = with pkgs; [ chatgpt ]; };
}
