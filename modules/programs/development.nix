{ pkgs, ... }:

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
  };
}
