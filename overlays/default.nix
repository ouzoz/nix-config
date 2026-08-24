rec {
  default = packages;

  packages = final: _: { ozozka = import ../pkgs { pkgs = final; }; };
}
