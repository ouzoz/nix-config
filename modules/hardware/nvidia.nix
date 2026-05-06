{ config, ... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # boot.kernelModules = [ "nvidia_uvm" ];
  # hardware.nvidia.forceFullCompositionPipeline = true;
  hardware.nvidia = {
    # nvidiaPersistenced = true;
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

  # environment.sessionVariables = {
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "nvidia";
    # NVIDIA_WAYLAND_DXGI = "1";
  # };

  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };
}
