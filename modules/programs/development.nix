{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    just

    prettier

    bun
    uv
    rustup

    texliveFull
    mermaid-cli
  ];
}
