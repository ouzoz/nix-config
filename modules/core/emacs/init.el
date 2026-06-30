;;; init.el --- Manual vanilla Emacs configuration

(cua-mode 1)
(setq select-enable-clipboard t)




(defun reload-oz-theme ()
  "Cleanly reload and refresh the custom Oz theme."
  (interactive)
  (disable-theme 'oz)
  (load-file (expand-file-name "~/.config/emacs/oz-theme.el")) ; Change to your exact file path
  (load-theme 'oz t)
  (message "Oz theme reloaded successfully!"))

;; Bind it to a quick shortcut, like Ctrl+c followed by t
(global-set-key (kbd "C-c t") 'reload-oz-theme)

(global-set-key (kbd "C-c e") 'eval-buffer)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Font
(set-face-attribute 'default nil
                    :font "Oziosevka"
                    :height 120)

;; Optional: make fixed-pitch and variable-pitch explicit
(set-face-attribute 'fixed-pitch nil
                    :font "Oziosevka"
                    :height 120)

(set-face-attribute 'variable-pitch nil
                    :font "Spectral"
                    :height 120)

(setq-default line-spacing 0.24)

;; Basic UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'oz t)

(window-divider-mode 1)





(setq user-full-name "Oğuzhan Özkaya")

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(setq create-lockfiles nil)

;; Backups and autosaves.
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t)))

(make-directory (expand-file-name "backups/" user-emacs-directory) t)
(make-directory (expand-file-name "auto-saves/" user-emacs-directory) t)

(fset 'yes-or-no-p 'y-or-n-p)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(blink-cursor-mode -1)
(column-number-mode 1)
(size-indication-mode 1)

(setq ring-bell-function 'ignore)

(show-paren-mode 1)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq sentence-end-double-space nil)

(setq scroll-margin 3
      scroll-conservatively 101
      scroll-preserve-screen-position t)

;; Case-insensitive completion.
(setq completion-ignore-case t
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

;; Enable recent files.
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; Remember cursor positions.
(save-place-mode 1)

;; -------------------------------------------------------------------
;; Files
;; -------------------------------------------------------------------

;; Auto-revert buffers when files change on disk.
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Follow symlinks to version-controlled files without asking.
(setq vc-follow-symlinks t)

;; -------------------------------------------------------------------
;; Dired
;; -------------------------------------------------------------------

(setq dired-listing-switches "-alh --group-directories-first")

;; Reuse same Dired buffer when pressing RET.
(setq dired-kill-when-opening-new-dired-buffer t)

;; -------------------------------------------------------------------
;; Programming
;; -------------------------------------------------------------------

(add-hook 'prog-mode-hook #'electric-pair-local-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)

;; Built-in syntax checking.
(add-hook 'prog-mode-hook #'flymake-mode)

;; Built-in LSP client, Emacs 29+.
;; Start manually with M-x eglot, or add hooks per language later.

;; -------------------------------------------------------------------
;; Compilation
;; -------------------------------------------------------------------

(setq compilation-scroll-output t)

(global-set-key (kbd "C-c c") #'compile)
(global-set-key (kbd "C-c r") #'recompile)

;; -------------------------------------------------------------------
;; Navigation
;; -------------------------------------------------------------------

(global-set-key (kbd "C-c g") #'grep)
(global-set-key (kbd "C-c o") #'occur)
(global-set-key (kbd "C-c i") #'imenu)

;; -------------------------------------------------------------------
;; Window movement
;; -------------------------------------------------------------------

(windmove-default-keybindings)

;; -------------------------------------------------------------------
;; Better defaults for built-in commands
;; -------------------------------------------------------------------

(global-set-key (kbd "C-x C-b") #'ibuffer)

;; -------------------------------------------------------------------
;; Server / emacsclient
;; -------------------------------------------------------------------

(require 'server)
(unless (server-running-p)
  (server-start))
