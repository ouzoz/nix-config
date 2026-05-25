{
  imports = [
    ../modules/system/nix.nix
    ../modules/system/boot.nix
    ../modules/system/network.nix
    ../modules/system/users.nix
    ../modules/system/core.nix
    ../modules/system/bash.nix
    ../modules/system/locale.nix

    ../modules/programs/git.nix
    ../modules/programs/tmux
    ../modules/programs/nvim
    ../modules/programs/yazi.nix
  ];
}
