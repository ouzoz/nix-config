;;; my-theme.el --- My cutom emacs theme -*- lexical-binding: t; -*-

;;; Commentary:
;; 


(deftheme my "My custom theme.")

(defgroup my-theme nil
  "Options for my theme."
  :group 'faces)

(defcustom my-theme-col-p "#09bea8"
  "Primary color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-col-s "#ff3c5b"
  "Secondary color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-col-f "#ffffff"
  "Foreground color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-col-m "#7e8180"
  "Muted foreground color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-col-o "#101212"
  "Overlay/background accent color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-col-b "#000000"
  "Background color."
  :type 'color
  :group 'my-theme)

(defcustom my-theme-fonts-mono "Oziosevka"
  "Monospace font family."
  :type 'string
  :group 'my-theme)

(defcustom my-theme-fonts-serif "Manuale"
  "Serif font family."
  :type 'string
  :group 'my-theme)

(defcustom my-theme-fonts-sans "Inter"
  "Sans-serif font family."
  :type 'string
  :group 'my-theme)

(defcustom my-theme-fonts-emoji "Noto Emoji Color"
  "Emoji font family."
  :type 'string
  :group 'my-theme)

(defcustom my-theme-font-size-b 120
  "Base font height."
  :type 'integer
  :group 'my-theme)

(defcustom my-theme-font-size-h 144
  "Heading font height."
  :type 'integer
  :group 'my-theme)

(defcustom my-theme-font-size-t 240
  "Title font height."
  :type 'integer
  :group 'my-theme)

;(custom-theme-set-variables
; 'my)

(let* (
      (my-theme-title-base `(:inherit variable-pitch-text :foreground ,my-theme-col-s :weight bold))
      (my-theme-title `(,@my-theme-title-base :height ,my-theme-font-size-t))
      (my-theme-heading `(,@my-theme-title-base :height ,my-theme-font-size-h))
      (my-theme-subheading `(,@my-theme-title-base :height ,my-theme-font-size-b))
      (my-theme-prominent `(:inherit variable-pitch-text :weight bold)))
(custom-theme-set-faces
  'my

  `(default ((t (:family ,my-theme-fonts-mono :height ,my-theme-font-size-b :background ,my-theme-col-b :foreground ,my-theme-col-f))))
  `(fixed-pitch ((t (:family ,my-theme-fonts-mono :height ,my-theme-font-size-b))))
  `(variable-pitch ((t (:family ,my-theme-fonts-serif :height ,my-theme-font-size-b))))
  `(variable-pitch-text ((t (:family ,my-theme-fonts-sans :height ,my-theme-font-size-b))))
  
  `(ansi-color-black ((t (:foreground ,my-theme-col-b))))
  `(ansi-color-red ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-green ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-yellow ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-blue ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-magenta ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-cyan ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-white ((t (:foreground ,my-theme-col-m))))
  `(ansi-color-bright-black ((t (:foreground ,my-theme-col-o))))
  `(ansi-color-bright-red ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-bright-green ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-bright-yellow ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-bright-blue ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-bright-magenta ((t (:foreground ,my-theme-col-s))))
  `(ansi-color-bright-cyan ((t (:foreground ,my-theme-col-p))))
  `(ansi-color-bright-white ((t (:foreground ,my-theme-col-f))))

  `(cursor ((t (:background ,my-theme-col-f))))
  `(region ((t (:background ,my-theme-col-o))))
  `(highlight ((t (:background ,my-theme-col-o))))
  `(fringe ((t (:background ,my-theme-col-b))))
  `(link ((t (:inherit fixed-pitch :foreground ,my-theme-col-p :underline t))))
  `(link-visited ((t (:foreground ,my-theme-col-m :underline t))))
  `(line-number ((t (:background ,my-theme-col-b :foreground ,my-theme-col-m))))
  `(line-number-current-line ((t (:background ,my-theme-col-b :foreground ,my-theme-col-f :weight bold))))
  `(vertical-border ((t (:background ,my-theme-col-b :foreground ,my-theme-col-o))))

  `(error ((t (:foreground ,my-theme-col-s :underline (:color ,my-theme-col-s :style wave)))))
  `(warning ((t (:foreground ,my-theme-col-p :underline (:color ,my-theme-col-p :style wave)))))
  
  `(mode-line ((t (:background ,my-theme-col-o :foreground ,my-theme-col-f))))
  `(mode-line-inactive ((t (:background ,my-theme-col-o :foreground ,my-theme-col-m))))
  `(header-line ((t (:inherit mode-line))))

  `(tab-line ((t (:inherit mode-line))))
  `(tab-line-tab ((t (:inherit mode-line))))
  `(tab-line-tab-current ((t (:inherit mode-line :weight bold))))
  `(tab-line-tab-inactive ((t (:inherit mode-line :foreground ,my-theme-col-m))))

  `(tab-bar ((t (:inherit mode-line :background ,my-theme-col-b))))
  `(tab-bar-tab ((t (:inherit tab-bar))))
  `(tab-bar-tab-highlight ((t (:inherit tab-bar))))
  `(tab-bar-tab-inactive ((t (:inherit tab-bar :foreground ,my-theme-col-m))))
  
  `(completions-common-part ((t (:foreground ,my-theme-col-m))))
  `(completions-first-difference ((t (:foreground ,my-theme-col-p :weight bold))))

  `(font-lock-constant-face ((t (:foreground ,my-theme-col-p))))
  `(font-lock-comment-face ((t (:inherit variable-pitch :foreground ,my-theme-col-m))))
  `(font-lock-keyword-face ((t (:foreground ,my-theme-col-m :weight bold))))
  `(font-lock-builtin-face ((t (:foreground ,my-theme-col-m))))
  `(font-lock-function-name-face ((t (:foreground ,my-theme-col-s))))
  `(font-lock-variable-name-face ((t (:foreground ,my-theme-col-f))))
  `(font-lock-type-face ((t (:foreground ,my-theme-col-f))))
  `(font-lock-string-face ((t (:foreground ,my-theme-col-p))))

  `(isearch ((t (:background ,my-theme-col-o :weight bold :underline (:color ,my-theme-col-s :style dashes)))))
  `(isearch-fail ((t (:foreground ,my-theme-col-s :weight bold))))
  `(lazy-highlight ((t (:background ,my-theme-col-o :weight bold :underline (:color ,my-theme-col-p :style dashes)))))

  `(log-view-message ((t (:foreground ,my-theme-col-m))))
  `(change-log-list ((t (:foreground ,my-theme-col-s))))
  
  `(log-edit-header ((t (:inherit variable-pitch-text :foreground ,my-theme-col-m))))
  `(log-edit-headers-separator ((t (:background ,my-theme-col-o :foreground ,my-theme-col-o :height 18))))
  `(log-edit-summary ((t (:inherit variable-pitch-text :foreground ,my-theme-col-f))))

  `(vc-dir-header ((t (:foreground ,my-theme-col-m))))
  `(vc-dir-file ((t (:inherit fixed-pitch))))
  `(vc-dir-directory ((t (:inherit dired-directory :foreground ,my-theme-col-m))))
  `(vc-dir-mark-indicator ((t (:foreground ,my-theme-col-p :weight bold))))
  `(vc-dir-status-edited ((t (:foreground ,my-theme-col-s))))

  `(dired-header ((t (:foreground ,my-theme-col-m :weight bold))))
  `(dired-directory ((t (:foreground ,my-theme-col-s :weight bold))))
  
  `(flymake-error ((t (:underline (:color ,my-theme-col-s :style wave)))))
  `(flymake-error-echo ((t (:foreground ,my-theme-col-s))))
  `(flymake-error-fringe ((t (:foreground ,my-theme-col-s))))
  `(flymake-warning ((t (:underline (:color ,my-theme-col-p :style wave)))))
  `(flymake-warning-echo ((t (:foreground ,my-theme-col-p))))
  `(flymake-warning-fringe ((t (:foreground ,my-theme-col-p))))
  `(flymake-note ((t (:underline (:color ,my-theme-col-m :style wave)))))
  `(flymake-note-echo ((t (:foreground ,my-theme-col-m))))
  `(flymake-note-fringe ((t (:foreground ,my-theme-col-m))))

  `(show-paren-match ((t (:background ,my-theme-col-o :foreground ,my-theme-col-p :weight bold))))
  `(show-paren-mismatch ((t (:background ,my-theme-col-s :foreground ,my-theme-col-f :weight bold))))

  `(info-title-1 ((t ,my-theme-title)))
  `(info-title-2 ((t ,my-theme-heading)))
  `(info-title-3 ((t ,my-theme-subheading)))
  `(info-title-4 ((t (:inherit info-title-3))))
  `(info-menu-header ((t ,my-theme-prominent)))
  `(Info-quoted ((t (:inherit fixed-pitch :foreground ,my-theme-col-p))))
  
  `(markdown-ts-heading-1 ((t ,my-theme-title)))
  `(markdown-ts-heading-2 ((t ,my-theme-heading)))
  `(markdown-ts-heading-3 ((t ,my-theme-subheading)))
  `(markdown-ts-heading-4 ((t (:inherit markdown-ts-heading-3))))
  `(markdown-ts-heading-5 ((t (:inherit markdown-ts-heading-4))))
  `(markdown-ts-heading-6 ((t (:inherit markdown-ts-heading-5))))
  `(markdown-ts-code-span ((t (:inherit fixed-pitch :foreground ,my-theme-col-p))))
  `(markdown-ts-code-block ((t (:inherit fixed-pitch))))
  `(markdown-ts-code-block-markup-hidden ((t (:inherit fixed-pitch :background ,my-theme-col-o))))
  `(markdown-ts-table-delimiter-cell ((t (:inherit markdown-ts-table :foreground ,my-theme-col-m))))
  `(markdown-ts-delimiter ((t (:foreground ,my-theme-col-m))))
  `(markdown-ts-task-checked ((t (:inherit fixed-pitch :foreground ,my-theme-col-p :weight bold))))
  `(markdown-ts-task-unchecked ((t (:inherit fixed-pitch :foreground ,my-theme-col-s :weight bold))))
  `(markdown-ts-list-marker ((t (:inherit fixed-pitch :foreground ,my-theme-col-m :weight bold))))
  `(markdown-ts-bold ((t ,my-theme-prominent)))))


(provide-theme 'my)

;;; my-theme.el ends here
