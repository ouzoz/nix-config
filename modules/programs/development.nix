{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    mermaid-cli
    texliveFull
    prettier
    cudatoolkit
    bun
    uv
    rustup
    just
  ];
}
