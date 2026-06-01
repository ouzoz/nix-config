{ pkgs, ... }:
{
  environment.sessionVariables = {
    OPENCODE_ENABLE_EXA = 1;
  };

  environment.shellAliases = {
    oc = "opencode";
  };

  environment.systemPackages = with pkgs; [
    opencode
  ];

  environment.etc = {
    "xdg/opencode/agents".source = ./agents;
    "xdg/opencode/commands".source = ./commands;
    "xdg/opencode/themes".source = ./themes;
    "xdg/opencode/opencode.json".source = ./opencode.json;
    "xdg/opencode/RULES.md".source = ./RULES.md;
  };

  system.userActivationScripts.linkOpencode = {
    text = ''
      mkdir -p ~/.config/opencode
      ln -sfn /etc/xdg/opencode/agents ~/.config/opencode/agents
      ln -sfn /etc/xdg/opencode/commands ~/.config/opencode/commands
      ln -sfn /etc/xdg/opencode/themes ~/.config/opencode/themes
      ln -sfn /etc/xdg/opencode/opencode.json ~/.config/opencode/opencode.json
      ln -sfn /etc/xdg/opencode/RULES.md ~/.config/opencode/RULES.md
    '';
  };
}
