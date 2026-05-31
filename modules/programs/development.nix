{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prettier
    bun
    uv
    rustup
    just
  ];
}
