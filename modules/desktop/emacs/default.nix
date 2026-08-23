{ config, pkgs, ... }:

let
  theme = config.my.theme;

  myEmacs = (pkgs.emacsPackagesFor pkgs.emacs31-pgtk).emacsWithPackages (
    epkgs: with epkgs; [ treesit-grammars.with-all-grammars ]
  );
in
{
  my.home.profiles.emacs.files = {
    ".config/emacs/early-init.el".source = ./early-init.el;
    ".config/emacs/init.el".source = ./init.el;
    ".config/emacs/lisp".source = ./lisp;
    ".config/emacs/my-theme.el".source = ./my-theme.el;
    ".config/emacs/my-constants.el".source = pkgs.writeText "my-constants.el" ''
      ;;; my-constants.el --- Nix generated theme constants -*- lexical-binding: t; -*-

      ;;; Commentary:
      ;;


      (setq my-theme-col-p "#${theme.colors.tokens.p}"
            my-theme-col-s "#${theme.colors.tokens.s}"
            my-theme-col-f "#${theme.colors.tokens.f}"
            my-theme-col-m "#${theme.colors.tokens.m}"
            my-theme-col-o "#${theme.colors.tokens.o}"
            my-theme-col-b "#${theme.colors.tokens.b}"
            my-theme-fonts-mono "${theme.fonts.mono}"
            my-theme-fonts-serif "${theme.fonts.serif}"
            my-theme-fonts-sans "${theme.fonts.sans}"
            my-theme-fonts-emoji "${theme.fonts.emoji}"
            my-theme-font-size-b ${toString theme.font-size.b}
            my-theme-font-size-h ${toString theme.font-size.h}
            my-theme-font-size-t ${toString theme.font-size.t})

      ;;; init.el ends here
    '';
  };

  environment.systemPackages = with pkgs; [
    hunspellDicts.en_US
    hunspellDicts.tr_TR
    hunspell

    mupdf

    myEmacs
  ];

  services.emacs = {
    enable = false;
    package = myEmacs;
    defaultEditor = true;
  };
}
