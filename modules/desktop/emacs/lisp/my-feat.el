;;; my-feat.el --- Built-in package and feature configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; 


(use-package vc
  :ensure nil
  :custom
  (vc-dir-auto-hide-up-to-date 'revert)) ; currently doesnt work

(use-package ispell
  :ensure nil
  :custom
  (ispell-program-name "hunspell")
  (ispell-dictionary "en_US,tr_TR")
  (ispell-silently-savep t)
  :config
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,tr_TR"))

(use-package flyspell
  :ensure nil
  :hook
  (text-mode . flyspell-mode)
  (prog-mode . flyspell-prog-mode)
  :custom
  (flyspell-issue-message-flag nil)
  (flyspell-prog-text-faces
   '(font-lock-comment-face font-lock-doc-face)))

(use-package tab-bar
  :ensure nil
  :custom
  (tab-bar-show t)
  (tab-bar-tab-hints t)
  (tab-bar-close-button-show nil)
  (tab-bar-new-button-show nil)
  (tab-bar-format '(tab-bar-format-tabs))
  (tab-bar-separator " ")
  (tab-bar-position 'bottom)
  :config
  (tab-bar-mode 1)
  (tab-bar-history-mode 1))

(use-package dired
  :custom
  (dired-free-space nil)
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-listing-switches "-ACxXlh --group-directories-first")
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  :hook
  (dired-mode . dired-hide-details-mode))

(use-package elec-pair
  :hook (prog-mode . electric-pair-local-mode))

; (use-package cua-base :config (cua-mode 1))

(use-package flymake
  :hook (prog-mode . flymake-mode))

(use-package eglot :defer t)

(use-package shell
  :hook (shell-mode . ansi-color-for-comint-mode-on))

(use-package treesit
  :ensure nil
  :init
  (setopt treesit-enabled-modes t))

(use-package subword
  :ensure nil
  :hook (prog-mode . subword-mode))

(provide 'my-feat)

;;; my-feat.el ends here
