;;; my-core.el --- Core settings -*- lexical-binding: t; -*-

;;; Commentary:
;; 


(defvar my-scroll-step 6 "Number of lines to scroll with custom scroll commands.")

(use-package emacs
  :custom
  (debug-on-error t)
  (warning-minimum-level :debug)

  (user-full-name "Oğuzhan Özkaya")
  (initial-scratch-message nil)
  (select-enable-clipboard t)
  (select-enable-primary t)
  (indent-tabs-mode nil)
  (tab-width 2)
  (tab-stop-list (number-sequence 2 200 2))
  (display-line-numbers-type 'relative)
  (sentence-end-double-space nil)
  (completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (create-lockfiles nil)
  (ring-bell-function 'ignore)
  (scroll-margin 3)
  (scroll-conservatively 101)
  (scroll-preserve-screen-position t)
  (initial-scratch-message nil)
  (ring-bell-function 'ignore)
  (line-spacing '(0.03 . 0.03)) ; 0.60 0.72
  (backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))
  (auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t)))
  (custom-file (expand-file-name "custom.el" user-emacs-directory))

  (mode-line-format
   '("%e"
     mode-line-front-space
     (:eval
      (propertize
       (buffer-name)
       'face (pcase (list (buffer-modified-p) buffer-read-only)
               (`(t t) '((t :inherit flymake-error-echo :weight bold)))
               (`(t nil) '((t :inherit flymake-warning-echo :weight bold)))
               (`(nil t) '((t :inherit mode-line-inactive :weight bold)))
               ('((t :inherit mode-line :weight bold))))))
     " "
     (:propertize "%I" face mode-line-inactive)
     " "
     (:eval (number-to-string (line-number-at-pos(point-max))))
     (:propertize ":" face mode-line-inactive)
     "%l"
     (:propertize "-" face mode-line-inactive)
     (:eval (number-to-string (save-excursion (end-of-line) (current-column))))
     (:propertize ":" face mode-line-inactive)
     "%c"

     "  "
     ; mode-line-format-right-align
     mode-line-modes mode-line-misc-info
     (vc-mode vc-mode)
     (project-mode-line project-mode-line-format)
     mode-line-end-spaces))

  :hook
  (prog-mode . display-line-numbers-mode)
  
  :config
  (global-auto-revert-mode 1)
  (windmove-default-keybindings)
  (load custom-file 'noerror)
  (make-directory (expand-file-name "backups/" user-emacs-directory) t)
  (make-directory (expand-file-name "auto-saves/" user-emacs-directory) t)
  (fset 'yes-or-no-p 'y-or-n-p)
  (show-paren-mode 1)
  (set-language-environment "UTF-8")
  (prefer-coding-system 'utf-8)
  (blink-cursor-mode -1)
  (column-number-mode 1)
  (size-indication-mode 1)
  (window-divider-mode -1)
  (fringe-mode '(3 . 3))
  ; (require `server)
  ; (unless (server-running-p) (server-start))

  :bind
  ("C-v" . (lambda () (interactive) (scroll-up-command my-scroll-step)))
  ("M-v" . (lambda () (interactive) (scroll-down-command my-scroll-step)))
  ("C-M-v" . (lambda () (interactive) (scroll-other-window my-scroll-step)))
  ("C-M-S-v" . (lambda () (interactive) (scroll-other-window (- my-scroll-step)))))


(provide 'my-core)

;;; my-core.el ends here
