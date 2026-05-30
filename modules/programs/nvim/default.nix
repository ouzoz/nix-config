{ pkgs, ... }:

let
  treesitter-runtime = import ./treesitter.nix { inherit pkgs; };
  # base-config = ./.;
in
{
  imports = [
    ./lsp.nix
  ];

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
      "parser".source = "${treesitter-runtime}/parser";
      "queries".source = "${treesitter-runtime}/queries";
    };
    # configure = {
    #   customRC = ''
    #     set runtimepath+=${treesitter-runtime}
    #     set runtimepath^=${base-config}
    #     luafile ${base-config}/init.lua
    #   '';
    # };
  };
}
