{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.misc;
in
{
  options.my.misc.lsp.enable = lib.mkEnableOption "language servers";

  config = lib.mkIf cfg.lsp.enable {
    environment.systemPackages = with pkgs; [
      bash-language-server
      vscode-langservers-extracted
      docker-language-server
      just-lsp
      marksman
      sqls
      texlab
      yaml-language-server
    ];
  };
}
