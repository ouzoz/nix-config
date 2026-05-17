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
    gb = "git branch";
    gch = "git checkout";
    gm = "git merge";
  };
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = true;
      user = {
        name = "oguzhanozkaya";
        email = "ozkayaoguzhan67@gmail.com";
      };
      core = {
        excludesfile = "${pkgs.writeText "gitignore-global" ''
          shell.nix
          .envrc
          .direnv/

          .agents/
        '' }";
      };
    };
  };
}
