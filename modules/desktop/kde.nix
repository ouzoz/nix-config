{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;

  services.displayManager.plasma-login-manager.enable = true;

  environment.systemPackages = with pkgs; [ wl-clipboard ];

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="nvidia", SYMLINK+="dri/by-driver/nvidia-card"
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="i915", SYMLINK+="dri/by-driver/intel-card"
  '';

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/by-driver/nvidia-card:/dev/dri/by-driver/intel-card";
  };
}
