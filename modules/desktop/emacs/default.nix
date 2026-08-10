{ pkgs, ... }:

let
  myEmacs = (pkgs.emacsPackagesFor pkgs.emacs31-pgtk).emacsWithPackages (
    epkgs: with epkgs; [ treesit-grammars.with-all-grammars ]
  );
in
{
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
