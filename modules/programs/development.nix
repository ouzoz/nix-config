{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang-tools

    prettier

    expat
    texliveFull
    mermaid-cli

    gcc
    bun
    uv
    rustup

    just
  ];
}
