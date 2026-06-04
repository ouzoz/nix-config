{ pkgs, ... }:
{
  environment.shellAliases = {
  };
  environment.systemPackages = with pkgs; [
    gh
  ];
}
