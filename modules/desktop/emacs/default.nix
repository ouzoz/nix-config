{ pkgs, ... }:

let
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
