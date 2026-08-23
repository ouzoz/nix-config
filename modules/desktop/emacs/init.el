;;; init.el --- Emacs config -*- lexical-binding: t; -*-

;;; Commentary:
;;


(load (expand-file-name "my-constants.el" user-emacs-directory))

(let ((default-directory (expand-file-name "lisp" user-emacs-directory)))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(require 'my-core)
(require 'my-feat)
(require 'my-modes)
(require 'my-editor)
(require 'my-extra)
(require 'my-env)
(load-theme 'my t)


;;; init.el ends here
