{ pkgs, ... }:

pkgs.iosevka.override {
  set = "Oziosevka";
  privateBuildPlan = builtins.readFile ./private-build-plans.toml;
}
