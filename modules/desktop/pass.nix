{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # keepassxc
  ];

  services.passSecretService.enable = true;
}
