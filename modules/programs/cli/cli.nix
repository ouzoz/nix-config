{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    OPENCODE_ENABLE_EXA = 1;
  };
  environment.shellAliases = {
    oc = "opencode";
    ff = "fastfetch";
    tok = "tokei -C -s lines";
    tokf = "tok -f";
    lan = "github-linguist";
  };
  environment.systemPackages = with pkgs; [
    opencode
    fastfetch
    tokei
    github-linguist
  ];
  system.userActivationScripts.linkOpencode = {
    text = ''
      mkdir -p ~/.config/opencode
      ln -sfn /etc/nixos/modules/programs/cli/opencode/agents ~/.config/opencode/agents
      ln -sfn /etc/nixos/modules/programs/cli/opencode/commands ~/.config/opencode/commands
      ln -sfn /etc/nixos/modules/programs/cli/opencode/themes ~/.config/opencode/themes
      ln -sfn /etc/nixos/modules/programs/cli/opencode/opencode.json ~/.config/opencode/opencode.json
      ln -sfn /etc/nixos/modules/programs/cli/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
    '';
  };
}
