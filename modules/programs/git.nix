{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user = {
        name = "oguzhanozkaya";
        email = "ozkayaoguzhan67@gmail.com";
      };
    };
  };
}
