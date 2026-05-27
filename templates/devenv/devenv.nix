{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  },
}:
let
  name = "moonai-shell";

  libs = with pkgs; [
    cudatoolkit
    libx11
    libxi
    libxrandr
    libxcursor
    libGL
    libGLU
    udev
    zlib
    openssl
    stdenv.cc.cc.lib
  ];
in
pkgs.mkShell {
  name = name;
  strictDeps = true;
  buildInputs = libs;
  NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;

  packages = with pkgs; [
    clang-tools
    cmake
    ninja
    vcpkg

    mermaid-cli
    texliveFull
    prettier
    bun
    uv
    rustup

    pkg-config
  ];

  env = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";
    CUDA_PATH = "${pkgs.cudatoolkit}";
  };

  shellHook = ''
    echo "- ${name} dev shell activated."
  '';
}
