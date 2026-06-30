(deftheme oz "oz theme")

(let* ((ozb "#000000")
       (ozo "#101212")
       (ozm "#7e8180")
       (ozf "#ffffff")
       (ozp "#09bea8")
       (ozs "#ff3c5b"))
  
(custom-theme-set-faces
  'oz
  `(default ((t (:background ,ozb :foreground ,ozf))))
  `(cursor ((t (:background ,ozf))))
  `(region ((t (:background ,ozo))))
  `(fringe ((t (:background ,ozo))))

  `(line-number ((t (:background ,ozb :foreground ,ozm))))

  ;; `(separator-line ((t (:background ,ozf :foreground ,ozm))))
  `(window-divider ((t (:background ,ozb :foreground ,ozo))))
  
  `(mode-line ((t (:background ,ozo :foreground ,ozf))))
  `(mode-line-inactive ((t (:background ,ozo :foreground ,ozm))))

  `(font-lock-comment-face ((t (:foreground ,ozm))))

  `(font-lock-keyword-face ((t (:foreground ,ozm :weight bold))))
  `(font-lock-builtin-face ((t (:foreground ,ozm))))
  `(font-lock-function-name-face ((t (:foreground ,ozs))))
  `(font-lock-variable-name-face ((t (:foreground ,ozf))))
  `(font-lock-type-face ((t (:foreground ,ozf))))

  `(font-lock-string-face ((t (:foreground ,ozp))))
))

(provide-theme 'oz)
