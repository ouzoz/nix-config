{ pkgs, ... }:
{
  environment.shellAliases = {
    gs = "git status";
    gc = "git add -A && git commit -m";
    gp = "git push";
    gpu = "git pull";
    gd = "git diff";
    gl = "git log --oneline -12";
    gi = "git diff --stat";
    grm = "git rm --cached";
    # alias gr = "git reset HEAD"
    # alias m = "git checkout master"
    # alias gch = "git checkout"
    # alias gm = "git merge"
  };
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user = {
        name = "oguzhanozkaya";
        email = "ozkayaoguzhan67@gmail.com";
      };
      core = {
        excludesfile = "${pkgs.writeText "gitignore-global" ''
          # shell.nix
          # .envrc
          # .direnv/

          .agents/
        '' }";
      };
    };
  };
}
