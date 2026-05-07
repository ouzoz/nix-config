{ lib, pkgs, ... }:

# let
  # libs = with pkgs; [
  #   cudatoolkit
  #
  #   glib
  #   glibc
  #   zlib
  #   openssl
  # ];
# in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    gcc14
    bun
    uv
    rustup
    just

    # pkg-config
  ];
  programs.nix-ld.libraries = with pkgs; [
    cudatoolkit
    glib
    glibc
    zlib
    openssl
    stdenv.cc.cc.lib
  ];

  environment.sessionVariables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    CUDA_HOME = "${pkgs.cudatoolkit}";
    CUDAToolkit_ROOT = "${pkgs.cudatoolkit}";
    CUDAFLAGS = "-I${pkgs.cudatoolkit}/include";
    NVCC_PREPEND_FLAGS = "-I${pkgs.cudatoolkit}/include";
    CUDACXX = "${pkgs.cudatoolkit}/bin/nvcc";
    CUDAHOSTCXX = "${pkgs.gcc14}/bin/g++";

    CC = "${pkgs.gcc14}/bin/gcc";
    CXX = "${pkgs.gcc14}/bin/g++";

    # LIBRARY_PATH = lib.makeLibraryPath libs;
    # PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" libs;
  };
}
