{ pkgs, ... }:
{
  environment.sessionVariables = {
    GH_TELEMETRY = "0";
  };

  environment.shellAliases = {
  };

  environment.systemPackages = with pkgs; [
    gh
  ];
}
