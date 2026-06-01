{ pkgs, ... }:
{
  environment.sessionVariables = {
    OPENCODE_ENABLE_EXA = 1;
    OPENCODE_CONFIG = "/etc/xdg/opencode/opencode.json";
    OPENCODE_CONFIG_DIR = "/etc/xdg/opencode";
  };

  environment.shellAliases = {
    oc = "opencode";
  };

  environment.systemPackages = with pkgs; [
    opencode
  ];

  # system.userActivationScripts.linkOpencode = {
  #   text = ''
  #     mkdir -p ~/.config/opencode
  #     ln -sfn /etc/nixos/modules/development/opencode/agents ~/.config/opencode/agents
  #     ln -sfn /etc/nixos/modules/development/opencode/commands ~/.config/opencode/commands
  #     ln -sfn /etc/nixos/modules/development/opencode/themes ~/.config/opencode/themes
  #     ln -sfn /etc/nixos/modules/development/opencode/opencode.json ~/.config/opencode/opencode.json
  #     ln -sfn /etc/nixos/modules/development/opencode/RULES.md ~/.config/opencode/RULES.md
  #   '';
  # };

  environment.etc = {
    "xdg/opencode/agents".source = ./agents;
    "xdg/opencode/commands".source = ./commands;
    "xdg/opencode/themes".source = ./themes;
    "xdg/opencode/opencode.json".source = ./opencode.json;
    "xdg/opencode/RULES.md".source = ./RULES.md;
  };
}
