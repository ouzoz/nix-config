{ lib, pkgs, ... }:

let
  globalBuildInputs = with pkgs; [
    cudatoolkit
    libx11 libxi libxrandr libxcursor libGL libGLU
    glib.dev
    zlib.dev
    openssl.dev
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    clang-tools
    cmake
    ninja
    vcpkg

    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    gcc
    bun
    uv
    rustup
    just

    pkg-config
  ];
  programs.nix-ld.libraries = with pkgs; [
    cudatoolkit
    libx11 libxi libxrandr libxcursor libGL libGLU
    udev
    glib
    glibc
    zlib
    openssl
    stdenv.cc.cc.lib
  ];

  environment.sessionVariables = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";
    # CMAKE_TOOLCHAIN_FILE = "${pkgs.vcpkg}/share/vcpkg/scripts/buildsystems/vcpkg.cmake";

    CUDA_PATH = "${pkgs.cudatoolkit}";
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDAToolkit_ROOT = "${pkgs.cudatoolkit}";
    CUDACXX = "${pkgs.cudatoolkit}/bin/nvcc";
    CUDAHOSTCXX = "${pkgs.gcc}/bin/g++";

    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";

    LIBRARY_PATH = lib.makeLibraryPath globalBuildInputs + ":/run/opengl-driver/lib";
    PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" globalBuildInputs;
  };
}
