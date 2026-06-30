{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ gh ];

    sessionVariables = {
      GH_TELEMETRY = "0";
    };

    shellAliases = { };
  };
}
