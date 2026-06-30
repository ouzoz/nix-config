_: {
  environment.shellAliases = {
    gs = "git status --short --branch";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gpu = "git pull";
    gd = "git diff";
    gdt = "git difftool";
    gl = "git log --oneline -6";
    gi = "git diff --stat";
    gb = "git branch";
    gch = "git checkout";
    gm = "git merge";
  };

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = true;
      safe.directory = "/etc/nixos";
      user = {
        name = "ouzoz";
        email = "ozkayaoguzhan67@gmail.com";
      };

      diff.tool = "nvimdiff";
      difftool.nvimdiff.cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
      difftool = {
        prompt = false;
        trustExitCode = true;
      };

      merge.tool = "nvimdiff";
      mergetool.nvimdiff.cmd = ''nvim -d "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'';
      mergetool = {
        prompt = false;
      };
    };
  };
}
