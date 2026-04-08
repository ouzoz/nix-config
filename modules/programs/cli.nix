{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    OPENCODE_ENABLE_EXA = 1;
  };
  environment.shellAliases = {
    oc = "opencode";
    tok = "tokei -C -s lines -n dots";
    tokf = "tok -f";
    lan = "github-linguist";
  };
  environment.systemPackages = with pkgs; [
    opencode
    tokei
    github-linguist
    fastfetch
  ];
}
