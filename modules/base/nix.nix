{ inputs, ... }:

{
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    # firewall.enable = true;
    # sshServe.enable = true;
    checkAllErrors = true;
    checkConfig = true;
    # daemonCPUSchedPolicy = "other";

    settings = {
      auto-optimise-store = true;
      cores = 0;
      max-jobs = "auto";
      sandbox = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise = {
      automatic = true;
      persistent = true;
      dates = "daily";
    };

    gc = {
      automatic = true;
      persistent = true;
      dates = "daily"; # "weekly", "01.00"
      options = "--delete-older-than 6d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;

  systemd.enableStrictShellChecks = true;

  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [];
  };
}
