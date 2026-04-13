{ config, pkgs, ... }:

{
  environment.sessionVariables = {
  };
  environment.shellAliases = {
  };
  environment.systemPackages = with pkgs; [
      texliveFull
      plantuml
      graphviz

      pylyzer
      clang-tools
      lua-language-server
  ];
  system.userActivationScripts.linkOpencode = {
  };
}
