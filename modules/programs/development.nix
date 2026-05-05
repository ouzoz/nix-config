{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    just

    bun
    uv
    rustup

    texliveFull
    mermaid-cli
  ];
}
