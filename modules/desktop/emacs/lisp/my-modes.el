;;; my-modes.el --- Modes -*- lexical-binding: t; -*-

;;; Commentary:
;;


(use-package log-edit
  :defer t
  :hook
  (log-edit-mode . (lambda () (buffer-face-set 'variable-pitch))))

(use-package term
  :ensure nil
  :hook (term-mode . (lambda ()
                       (setq-local scroll-margin 0)
                       (setq-local scroll-conservatively 101)
                       (setq-local scroll-step 1))))

(use-package info
  :hook
  (Info-mode . my-info-setup)
  :config
  (defun my-info-setup ()
    (buffer-face-set 'variable-pitch)))

(use-package markdown-ts-mode
  :mode ("\\.\\(?:md\\|markdown\\|mdown\\|mkd\\)\\'" . markdown-ts-mode)
  :custom
  (markdown-ts-hide-markup t)
  (markdown-ts-inline-images t)
  (markdown-ts-image-max-width 'window)
  (markdown-ts-fontify-code-blocks-natively t)
  (markdown-ts-enable-code-block-context-mode t)
  (markdown-ts-enable-table-mode t)
  (markdown-ts-default-folding 'show-all)
  (markdown-ts-unordered-list-marker '(("∙ " . "- "))) ; ⋅
  (markdown-ts-checked-checkbox '("✔ " . "* "))
  (markdown-ts-unchecked-checkbox '("⬦ " . "+ "))
  :hook
  (markdown-ts-mode . my-markdown-writing-setup)
  :bind (:map markdown-ts-mode-map
              ("<f9>" . markdown-ts-toggle-hide-markup))
  :config
  (defun my-markdown-sync-line-numbers (&rest _)
    (display-line-numbers-mode (if markdown-ts-hide-markup -1 1)))
  (advice-add 'markdown-ts-toggle-hide-markup
              :after #'my-markdown-sync-line-numbers)
  (defun my-markdown-writing-setup ()
    "Configure Markdown."
    (buffer-face-set 'variable-pitch)
    (font-lock-add-keywords
     nil
     '(("^\\([ \t]+\\)" (1 'fixed-pitch prepend)))
     'append)
    (my-markdown-sync-line-numbers)
    (electric-pair-local-mode 1)))

(use-package treesit-x
  :ensure nil
  :demand t
  :hook
  (just-ts-mode . eglot-ensure)
  :config
  (define-treesit-generic-mode just-ts-mode
    "Tree-sitter mode for Justfiles."
    :lang 'just
    :auto-mode "\\(?:^\\|/\\)[Jj]ustfile\\'"
    :parent #'prog-mode
    :name "Just")
  (with-eval-after-load 'eglot
    (add-to-list
     'eglot-server-programs
     '((just-ts-mode :language-id "just") . ("just-lsp")))))

(use-package treesit-x
  :ensure nil
  :demand t
  :hook
  (nix-ts-mode . eglot-ensure)
  :config
  (define-treesit-generic-mode nix-ts-mode
    "Tree-sitter mode for Nix expressions."
    :lang 'nix
    :auto-mode "\\.nix\\'"
    :parent #'prog-mode
    :name "Nix")
  (with-eval-after-load 'eglot
    (add-to-list
     'eglot-server-programs
     '((nix-ts-mode :language-id "nix") . ("nixd")))))


(provide 'my-modes)

;;; my-modes.el ends here
