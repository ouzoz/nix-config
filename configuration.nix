{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "ouz";
  # networking.wireless.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  console.keyMap = "trq";
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  users.users.ouz = {
    isNormalUser = true;
    description = "ouz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 6d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0"; 
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  systemd.user.services.solaar = {
    enable = true;
    description = "Solaar background service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.solaar}/bin/solaar --window=hide";
    };
  };

  fonts.packages = with pkgs; [
    source-sans
    corefonts
  ];

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user = {
        name = "oguzhanozkaya";
        email = "ozkayaoguzhan67@gmail.com";
      };
    };
  };

  programs.tmux = {
    enable = true;
    secureSocket = true;
  };

  programs.yazi.enable = true;

  environment.systemPackages = with pkgs; [
    brave

    opencode
    alacritty
    wl-clipboard

    # obsidian
    libreoffice
    # thunderbird
    
    p7zip
    unzip
    zip
    unrar
    smartmontools
    openconnect
    
    just
    tokei
    github-linguist
    wget

    waybar
    wofi
    mako
    grim
    slurp
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    wrapperFeatures.gtk = true;
  };

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NVIDIA_WAYLAND_DXGI = "1";
    __GL_MaxFramesAllowed = "1";
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu";
        user = "ouz"; 
      };
      default_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu";
        user = "ouz"; 
      };
    };
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
