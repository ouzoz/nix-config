{ lib, pkgs, ... }:

let
  libs = with pkgs; [
    cudatoolkit

    udev
    libx11 libxi libxrandr libxcursor libGL libGLU

    glib
    zlib
    openssl
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

    libx11 libxi libxrandr libxcursor libGL libGLU

    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    gcc14
    bun
    uv
    rustup
    just

    pkg-config
  ];
  programs.nix-ld.libraries = with pkgs; [
    cudatoolkit

    udev
    libx11 libxi libxrandr libxcursor libGL libGLU

    glib
    glibc
    zlib
    openssl
    stdenv.cc.cc.lib
  ];

  environment.sessionVariables = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";

    CUDA_PATH = "${pkgs.cudatoolkit}";
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDAToolkit_ROOT = "${pkgs.cudatoolkit}";
    CUDAFLAGS = "-I${pkgs.cudatoolkit}/include";
    NVCC_PREPEND_FLAGS = "-I${pkgs.cudatoolkit}/include";
    CUDACXX = "${pkgs.cudatoolkit}/bin/nvcc";
    CUDAHOSTCXX = "${pkgs.gcc14}/bin/g++";

    CC = "${pkgs.gcc14}/bin/gcc";
    CXX = "${pkgs.gcc14}/bin/g++";

    CPATH = lib.makeSearchPath "include" libs;
    C_INCLUDE_PATH = lib.makeSearchPath "include" libs;
    CPLUS_INCLUDE_PATH = lib.makeSearchPath "include" libs;

    LIBRARY_PATH = lib.makeLibraryPath libs + ":/run/opengl-driver/lib";
    # PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" globalBuildInputs;
    PKG_CONFIG_PATH =
      lib.makeSearchPath "lib/pkgconfig" libs
      + ":"
      + lib.makeSearchPath "share/pkgconfig" libs;
  };
}
