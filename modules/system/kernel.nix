{ pkgs }:
pkgs.linuxPackages_latest.extend (self: super: {
  kernel = super.kernel.overrideAttrs (oldAttrs: {
    pname = "linux-native-optimized";
    structuredExtraConfig = with pkgs.lib.kernel; {
      GENERIC_CPU = mkForce no;
      X86_NATIVE_CPU = yes;
    };
  });
})

# { config, lib, pkgs, ... }:
#
# let
#   cfg = config.mySystem.hardware.customKernel;
#   customKernelPackages = pkgs.callPackage ../../packages/custom-kernel.nix {};
# in {
#   options.mySystem.hardware.customKernel = {
#     enable = lib.mkEnableOption "Natively optimized custom upstream kernel";
#   };
#
#   config = lib.mkIf cfg.enable {
#     boot.kernelPackages = customKernelPackages;
#     nix.settings.extra-sandbox-paths = [ "/var/cache/ccache" ];
#     nix.settings.builders = lib.mkForce "";
#   };
# }

# mySystem.hardware.customKernel.enable = true;
