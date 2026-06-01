{ pkgs }:
{
  packages = with pkgs; [
    nixfmt
    treefmt
    nixd
  ];
}
