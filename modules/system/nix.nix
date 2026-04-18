{ ... }:

{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 6d";
    };
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    # dev shell templates
    ozd = "direnv allow";
    ozdm = "nix-shell";
    ozd-empty       = "nix flake init -t /etc/nixos#empty";
    ozd-tex         = "nix flake init -t /etc/nixos#tex";
    ozd-python      = "nix flake init -t /etc/nixos#python";
    ozd-typescript  = "nix flake init -t /etc/nixos#typescript";
    ozd-rust        = "nix flake init -t /etc/nixos#rust";
    ozd-cpp         = "nix flake init -t /etc/nixos#cpp";
  };
}
