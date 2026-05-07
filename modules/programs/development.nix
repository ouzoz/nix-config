{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    clang-tools
    cmake
    ninja
    vcpkg
    gcc
    stdenv.cc
    stdenv.cc.cc

    mermaid-cli
    texliveFull

    prettier
    bun
    uv
    rustup

    just

    # pkg-config
  ];
  programs.nix-ld.libraries = with pkgs; [
    # cudaPackages.cuda_cudart
    # cudaPackages.cuda_nvcc
    # linuxPackages.nvidia_x11

    # cudaPackages.libcublas
    # cudaPackages.libcufft
    # cudaPackages.libcurand
    # cudaPackages.libcusolver
    # cudaPackages.libcusparse
    # cudaPackages.cudnn

    zlib
    glib
    glibc
    openssl
    # xorg.libX11
    stdenv.cc.cc
    stdenv.cc.cc.lib
  ];

  environment.sessionVariables = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";
    CC = "gcc";
    CXX = "g++";
    # CMAKE_TOOLCHAIN_FILE = "${pkgs.vcpkg}/share/vcpkg/scripts/buildsystems/vcpkg.cmake";
    #
    # CUDA_PATH = "${pkgs.cudatoolkit}";
    # CUDA_HOME = "${pkgs.cudatoolkit}";
    # CUDAToolkit_ROOT = "${pkgs.cudatoolkit}";
    #
    # FONTCONFIG_FILE = "${pkgs.makeFontsConf {
    #   fontDirectories = [ pkgs.corefonts ];
    # }}";
    #
    # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath libs;
  };
}
