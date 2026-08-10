;;; init.el --- Emacs config -*- lexical-binding: t; -*-

;;; Commentary:
;;


(setq my-theme-col-p "#09bea8"
      my-theme-col-s "#ff3c5b"
      my-theme-col-f "#ffffff"
      my-theme-col-m "#7e8180"
      my-theme-col-o "#101212"
      my-theme-col-b "#000000"
      my-theme-fonts-mono "Oziosevka"
      my-theme-fonts-serif "Manuale"
      my-theme-fonts-sans "Inter"
      my-theme-fonts-emoji "Noto Emoji Color"
      my-theme-font-size-b 120
      my-theme-font-size-h 144
      my-theme-font-size-t 240)

(let ((default-directory (expand-file-name "lisp" user-emacs-directory)))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(require 'my-core)
(require 'my-feat)
(require 'my-modes)
(require 'my-editor)
(require 'my-extra)
(load-theme 'my t)


;;; init.el ends here
