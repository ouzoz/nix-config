{ pkgs, ... }:

{ environment.systemPackages = with pkgs; [ emacs-pgtk ]; }
