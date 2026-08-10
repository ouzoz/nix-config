{ pkgs, ... }: {
  services.passSecretService.enable = true;
  security.pam.services.login.gnupg.enable = true;

  environment.systemPackages = with pkgs; [
    pass
    gnupg
  ];

  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = false;
    enableExtraSocket = false;
    enableSSHSupport = false;
    pinentryPackage = pkgs.pinentry-curses; # pinentry-qt, pinentry-gtk2
    settings = {
      allow-preset-passphrase = true;
      default-cache-ttl = 600;
      max-cache-ttl = 7200;
    };
  };
}
