{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mermaid-cli
    texliveFull

    prettier
    bun
    uv
    rustup

    just
  ];
}
