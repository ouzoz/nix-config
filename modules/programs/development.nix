{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang-tools

    prettier

    texliveFull
    mermaid-cli

    bun
    uv
    rustup

    just
  ];
}
