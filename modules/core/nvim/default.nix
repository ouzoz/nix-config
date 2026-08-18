{ self, pkgs, ... }:

let
  treesitter-runtime = self.packages.${pkgs.stdenv.hostPlatform.system}.treesitter-runtime;
in
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
      "colors".source = ./colors;
      "spell".source = ./spell;
      "parser".source = "${treesitter-runtime}/parser";
      "queries".source = "${treesitter-runtime}/queries";
    };
  };
}
