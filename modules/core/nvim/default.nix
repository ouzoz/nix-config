{ my, ... }:
{
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
    runtime = {
      "init.lua".source = ./init.lua;
      "lua".source = ./lua;
      "lsp".source = ./lsp;
      "spell".source = ./spell;
      "parser".source = "${my.pkgs.treesitter-runtime}/parser";
      "queries".source = "${my.pkgs.treesitter-runtime}/queries";
    };
  };
}
