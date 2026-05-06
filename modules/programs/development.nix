{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang-tools

    prettier

    expat
    texliveFull
    mermaid-cli

    bun
    uv
    rustup

    just
  ];
}
