{ pkgs, ... }:

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
    bun
    uv
    rustup

    just

    # pkg-config
  ];

  environment.variables = {
    VCPKG_ROOT = "${pkgs.vcpkg}/share/vcpkg";
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
