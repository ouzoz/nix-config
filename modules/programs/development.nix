{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    stdenv.cc
    bun
    uv
    rustup
    just
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
    CUDAHOSTCXX = "${pkgs.stdenv.cc}/bin/c++";

    CC = "${pkgs.stdenv.cc}/bin/cc";
    CXX = "${pkgs.stdenv.cc}/bin/c++";
  };
}
