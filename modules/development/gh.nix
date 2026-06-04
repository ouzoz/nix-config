{ pkgs, ... }:
{
  environment.sessionVariables = {
    GH_TELEMETRY=false;
  };

  environment.shellAliases = {
  };

  environment.systemPackages = with pkgs; [
    gh
  ];
}
