;;; my-editor.el --- Custom editor workflows -*- lexical-binding: t; -*-

;;; Commentary:
;; 


(require 'project)
(require 'dired)
(require 'term)
(require 'cl-lib)
(require 'seq)
(require 'tab-bar)
(require 'vc-dir)

;; Left and right side windows use the full frame height.
;; The bottom terminal therefore occupies only the central area.
(setq window-sides-vertical t)

(defgroup my-layout nil
  "Project-oriented editor layout."
  :group 'windows)

(defcustom my-layout-left-width (/ 1.0 6)
  "Width of the left sidebar as a fraction of the frame."
  :type 'number
  :group 'my-layout)

(defcustom my-layout-left-panel-weights
  '((buffers . 1)
    (vc-dir . 3)
    (dired . 2))
  "Relative heights of the buffers, VC, and Dired panels.

The values are normalized.  The default weights allocate one-sixth,
three-sixths, and two-sixths respectively."
  :type '(alist :key-type symbol :value-type number)
  :group 'my-layout)

(defcustom my-layout-bottom-height (/ 1.0 3)
  "Height of the bottom terminal as a fraction of the frame."
  :type 'number
  :group 'my-layout)

(defcustom my-layout-agent-width (/ 1.0 3)
  "Width of the right agent terminal as a fraction of the frame."
  :type 'number
  :group 'my-layout)

(defcustom my-layout-shell
  (or explicit-shell-file-name
      shell-file-name
      (getenv "SHELL"))
  "Program run in the bottom terminal."
  :type 'string
  :group 'my-layout)

(defcustom my-layout-agent-command my-layout-shell
  "Program run in the right agent terminal.

Set this to an agent executable when desired."
  :type 'string
  :group 'my-layout)

(defvar my-layout--refreshing nil)
(defvar my-layout--resizing nil)
(defvar my-layout--project-buffer-orders
  (make-hash-table :test #'equal))
(defvar my-layout--known-buffer-names
  (make-hash-table :test #'eq))
(defvar my-layout--excluded-buffer nil)

(defconst my-layout--left-panel-kinds
  '(project-buffers project-vc project-dired))

(defvar-local my-layout-project nil
  "Project represented by the current layout panel.")

(defvar-local my-layout--tracked-project-root nil)
(defvar-local my-layout--tracked-modified-p nil)
(defvar-local my-layout--render-state nil)


;;;; Current-tab identity

(defun my-layout--new-tab-id ()
  "Return a new layout tab identifier."
  (substring
   (md5
    (format "%s:%s:%s"
            (float-time)
            (random)
            (emacs-pid)))
   0 10))

(defun my-layout-tab-id ()
  "Return a stable identifier stored in the current Emacs tab."
  (let* ((tab
          (seq-find
           (lambda (item)
             (eq (car item) 'current-tab))
           (funcall tab-bar-tabs-function)))

         (cell
          (assq 'my-layout-id tab)))

    (or (cdr cell)
        (let ((id (my-layout--new-tab-id)))
          ;; Extra tab parameters are retained by tab-bar.
          (setcdr tab
                  (cons (cons 'my-layout-id id)
                        (cdr tab)))

          id))))

(defun my-layout--initialize-opened-tab (tab)
  "Give newly opened TAB independent layout state."
  (let* ((selected-tab-p (memq tab (tab-bar-tabs)))
         (tabs (and selected-tab-p (frame-parameter nil 'tabs)))
         (new-tab-p (and selected-tab-p (> (length tabs) 1)))
         (cell (assq 'my-layout-id tab)))
    (when (or new-tab-p (not cell))
      (if cell
          (setcdr cell (my-layout--new-tab-id))
        (setcdr tab
                (cons
                 (cons 'my-layout-id (my-layout--new-tab-id))
                 (cdr tab)))))
    (when new-tab-p
      (dolist (kind
               (append
                my-layout--left-panel-kinds
                '(bottom-term agent-term)))
        (my-layout-delete-window kind)))))

(add-hook
 'tab-bar-tab-post-open-functions
 #'my-layout--initialize-opened-tab)

(defun my-layout-id (root)
  "Return an identifier unique to ROOT and the current Emacs tab."
  (substring
   (md5
    (format "%s:%s"
            (expand-file-name root)
            (my-layout-tab-id)))
   0 10))


;;;; General helpers

(defun my-layout-window (kind &optional frame)
  "Return the visible layout window identified by KIND."
  (seq-find
   (lambda (window)
     (eq (window-parameter window 'my-layout) kind))
   (window-list frame 'no-minibuffer)))

(defun my-layout-main-window ()
  "Return the largest non-side window in the current tab."
  (car
   (sort
    (seq-filter
     (lambda (window)
       (not (window-parameter window 'window-side)))
     (window-list nil 'no-minibuffer))
    (lambda (window-a window-b)
       (>
        (* (window-total-width window-a)
           (window-total-height window-a))
        (* (window-total-width window-b)
           (window-total-height window-b)))))))

(defun my-layout-hide-top-lines ()
  "Hide header and tab lines in the current buffer."
  (setq-local header-line-format nil
              tab-line-format nil))

(defun my-layout-hide-sidebar-chrome ()
  "Hide UI lines in the current sidebar buffer."
  (my-layout-hide-top-lines)
  (setq-local mode-line-format nil))

(defun my-layout-delete-window (kind)
  "Delete layout window KIND without killing its buffer."
  (when-let* ((window (my-layout-window kind)))
    (set-window-dedicated-p window nil)
    (delete-window window)))

(defun my-layout-display-main (buffer)
  "Display BUFFER in the main editing window."
  (if-let* ((window (my-layout-main-window)))
      (progn
        (set-window-buffer window buffer)
        (select-window window))

    (pop-to-buffer buffer)))

(defun my-layout-current-project ()
  "Return the project represented by the current layout context."
  (or
   (seq-some
    (lambda (kind)
      (when-let* ((window (my-layout-window kind)))
        (buffer-local-value
         'my-layout-project
         (window-buffer window))))
    my-layout--left-panel-kinds)
   (project-current nil)))

(defun my-layout-project-root ()
  "Return the most relevant project root.

Use the open sidebar's project, then the current buffer's project,
and finally `default-directory`."
  (if-let* ((project (my-layout-current-project)))
      (project-root project)
    default-directory))

(defun my-layout--project-key (project)
  "Return the normalized root used to identify PROJECT."
  (file-name-as-directory
   (expand-file-name (project-root project))))


;;;; Project file-buffer state

(defun my-layout--remove-project-buffer (buffer root)
  "Remove BUFFER from the tracked order for ROOT."
  (when root
    (let ((order
           (delq
            buffer
            (copy-sequence
             (gethash root my-layout--project-buffer-orders)))))
      (if order
          (puthash root order my-layout--project-buffer-orders)
        (remhash root my-layout--project-buffer-orders)))))

(defun my-layout--untrack-current-buffer (&optional quiet)
  "Stop tracking the current file buffer."
  (my-layout--remove-project-buffer
   (current-buffer)
   my-layout--tracked-project-root)
  (setq my-layout--tracked-project-root nil)
  (remhash (current-buffer) my-layout--known-buffer-names)
  (remove-hook
   'after-change-functions
   #'my-layout--refresh-buffer-modification
   t)
  (remove-hook
   'post-command-hook
   #'my-layout--refresh-buffer-modification
   t)
  (remove-hook
   'after-save-hook
   #'my-layout--refresh-saved-buffer
   t)
  (remove-hook
   'after-revert-hook
   #'my-layout--refresh-saved-buffer
   t)
  (remove-hook
   'kill-buffer-hook
   #'my-layout--untrack-current-buffer
   t)
  (unless quiet
    (let ((my-layout--excluded-buffer (current-buffer)))
      (my-layout-refresh-project-buffers))))

(defun my-layout--refresh-buffer-modification (&rest _)
  "Refresh panels when the current buffer's modified state changes."
  (let ((modified (buffer-modified-p)))
    (unless (eq modified my-layout--tracked-modified-p)
      (setq my-layout--tracked-modified-p modified)
      (my-layout-refresh-project-buffers))))

(defun my-layout--refresh-saved-buffer ()
  "Refresh panels after saving or reverting the current buffer."
  (setq my-layout--tracked-modified-p (buffer-modified-p))
  (my-layout-refresh-project-buffers))

(defun my-layout--track-current-buffer (&optional quiet)
  "Track the current file buffer in project opening order.

When QUIET is non-nil, do not refresh visible panels."
  (if-let* ((file buffer-file-name)
            (project
             (project-current nil (file-name-directory file)))
            (root (my-layout--project-key project)))
      (progn
        (unless (equal root my-layout--tracked-project-root)
          (my-layout--remove-project-buffer
           (current-buffer)
           my-layout--tracked-project-root)
          (setq my-layout--tracked-project-root root))
        (let ((order
               (gethash root my-layout--project-buffer-orders)))
          (unless (memq (current-buffer) order)
            (puthash
             root
             (append order (list (current-buffer)))
             my-layout--project-buffer-orders)))
        (setq my-layout--tracked-modified-p (buffer-modified-p))
        (puthash
         (current-buffer)
         (buffer-name)
         my-layout--known-buffer-names)
        (add-hook
         'after-change-functions
         #'my-layout--refresh-buffer-modification
         nil t)
        (add-hook
         'post-command-hook
         #'my-layout--refresh-buffer-modification
         nil t)
        (add-hook
         'after-save-hook
         #'my-layout--refresh-saved-buffer
         nil t)
        (add-hook
         'after-revert-hook
         #'my-layout--refresh-saved-buffer
         nil t)
        (add-hook
         'kill-buffer-hook
         #'my-layout--untrack-current-buffer
         nil t)
        (unless quiet
          (my-layout-refresh-project-buffers)))
    (when my-layout--tracked-project-root
      (my-layout--untrack-current-buffer quiet))))

(defun my-layout--project-file-buffers (project)
  "Return live file-visiting buffers belonging to PROJECT."
  (seq-filter
   (lambda (buffer)
     (and (buffer-live-p buffer)
          (not (eq buffer my-layout--excluded-buffer))
          (buffer-local-value 'buffer-file-name buffer)))
   (project-buffers project)))

(defun my-layout-ordered-project-buffers (project)
  "Return PROJECT's file buffers in tracked user-defined order."
  (let* ((root (my-layout--project-key project))
         (candidates (my-layout--project-file-buffers project))
         (candidate-set (make-hash-table :test #'eq))
         (tracked-set (make-hash-table :test #'eq))
         (tracked nil)
         (new nil)
         (order nil))
    (dolist (buffer candidates)
      (puthash buffer t candidate-set))
    (dolist (buffer
             (gethash root my-layout--project-buffer-orders))
      (when (gethash buffer candidate-set)
        (push buffer tracked)
        (puthash buffer t tracked-set)))
    (setq tracked (nreverse tracked))
    (dolist (buffer (reverse candidates))
      (unless (gethash buffer tracked-set)
        (push buffer new)))
    (setq new (nreverse new)
          order (append tracked new))
    (if order
        (puthash root order my-layout--project-buffer-orders)
      (remhash root my-layout--project-buffer-orders))
    order))


;;;; Project-buffer panel

(defvar-keymap my-layout-buffer-mode-map
  :parent special-mode-map

  "RET"
  #'my-layout-open-project-buffer

  "<return>"
  #'my-layout-open-project-buffer

  "n"
  #'next-line

  "p"
  #'previous-line

  "M-<up>"
  #'my-layout-move-project-buffer-up

  "M-<down>"
  #'my-layout-move-project-buffer-down)

(define-derived-mode
  my-layout-buffer-mode
  special-mode
  "Project-Buffers"
  "Major mode for the project-buffer panel."
  (setq-local truncate-lines t)
  (my-layout-hide-sidebar-chrome))

(defun my-layout-buffer-at-point ()
  "Return the project file buffer represented by the current line."
  (get-text-property
   (line-beginning-position)
   'my-layout-buffer))

(defun my-layout-project-buffer-face (buffer &optional frame)
  "Return BUFFER's panel face according to modification and visibility.

FRAME defaults to the selected frame."
  (let ((visible
         (get-buffer-window buffer (or frame (selected-frame)))))
    (cond
     ((buffer-modified-p buffer)
      (if visible
          'dired-directory
        'dired-header))
     (visible 'tab-bar-tab)
     (t 'tab-bar-tab-inactive))))

(defun my-layout-render-project-buffers (&optional frame)
  "Render project buffers in the current panel."
  (let* ((buffers
          (my-layout-ordered-project-buffers my-layout-project))
         (entries
          (mapcar
           (lambda (buffer)
             (list
              buffer
              (buffer-name buffer)
              (my-layout-project-buffer-face buffer frame)))
           buffers)))
    (unless (equal entries my-layout--render-state)
      (let* ((selected (my-layout-buffer-at-point))
             (panel (current-buffer))
             (panel-windows
              (get-buffer-window-list panel nil 'visible))
             (window-items
              (mapcar
               (lambda (window)
                 (cons
                  window
                  (save-excursion
                    (goto-char (window-point window))
                    (my-layout-buffer-at-point))))
               panel-windows))
             (inhibit-read-only t)
             (positions nil))
        (erase-buffer)
        (cl-loop
         for entry in entries
         for number from 1
         do
         (let ((start (point))
               (buffer (nth 0 entry)))
           (insert (format "%-4d%s" number (nth 1 entry)))
           (add-text-properties
            start
            (point)
            `(face ,(nth 2 entry)
              my-layout-buffer ,buffer
              mouse-face highlight
              help-echo "RET: open; M-up/down: reorder"))
           (push (cons buffer start) positions)
           (insert "\n")))
        (setq my-layout--render-state entries)
        (goto-char (or (alist-get selected positions) (point-min)))
        (dolist (window-item window-items)
          (let ((window (car window-item)))
            (when (and (window-live-p window)
                       (eq (window-buffer window) panel))
              (set-window-point
               window
               (or
                (alist-get (cdr window-item) positions)
                (point-min))))))
        (set-buffer-modified-p nil)))))

(defun my-layout-project-buffer (project)
  "Return the project-buffer panel for PROJECT."
  (let* ((root
          (project-root project))
         (buffer
          (get-buffer-create
           (format
            " *Project Buffers:%s*"
            (my-layout-id root)))))

    (with-current-buffer buffer
      (unless
          (derived-mode-p 'my-layout-buffer-mode)
        (my-layout-buffer-mode))
      (setq-local my-layout-project project
                  default-directory root)
      (my-layout-render-project-buffers))
    buffer))

(defun my-layout-open-project-buffer ()
  "Open the project buffer at point in the main window."
  (interactive)
  (if-let* ((buffer (my-layout-buffer-at-point)))
      (my-layout-display-main buffer)
    (user-error "No buffer on this line")))

(defun my-layout-move-project-buffer (offset)
  "Move the project buffer at point by OFFSET positions."
  (let* ((buffer (my-layout-buffer-at-point))
         (project my-layout-project)
         (root (and project (my-layout--project-key project)))
         (order
          (and project
               (copy-sequence
                (my-layout-ordered-project-buffers project))))
         (index (and buffer (seq-position order buffer #'eq)))
         (target (and index (+ index offset))))
    (unless index
      (user-error "No buffer on this line"))
    (unless (and (>= target 0) (< target (length order)))
      (user-error "Cannot move buffer further"))
    (let ((other (nth target order)))
      (setcar (nthcdr target order) buffer)
      (setcar (nthcdr index order) other))
    (puthash root order my-layout--project-buffer-orders)
    (my-layout-refresh-project-buffers)))

(defun my-layout-move-project-buffer-up ()
  "Move the project buffer at point one position up."
  (interactive)
  (my-layout-move-project-buffer -1))

(defun my-layout-move-project-buffer-down ()
  "Move the project buffer at point one position down."
  (interactive)
  (my-layout-move-project-buffer 1))

(defun my-layout-refresh-project-buffers (&optional frame &rest _)
  "Automatically refresh visible project-buffer panels."
  (unless my-layout--refreshing
    (let ((my-layout--refreshing t)
          (frames
           (if (framep frame)
               (list frame)
             (frame-list))))
      (dolist (candidate frames)
        (when (frame-visible-p candidate)
          (dolist (window (window-list candidate 'no-minibuffer))
            (when (eq (window-parameter window 'my-layout)
                      'project-buffers)
              (with-current-buffer (window-buffer window)
                (when my-layout-project
                  (my-layout-render-project-buffers candidate))))))))))

(defun my-layout--refresh-renamed-project-buffers ()
  "Refresh panels only when a tracked buffer name changed."
  (let ((changed nil))
    (maphash
     (lambda (_root buffers)
       (dolist (buffer buffers)
         (when (buffer-live-p buffer)
           (let ((name (buffer-name buffer)))
             (unless (equal name
                            (gethash buffer my-layout--known-buffer-names))
               (puthash buffer name my-layout--known-buffer-names)
               (setq changed t))))))
     my-layout--project-buffer-orders)
    (when changed
      (my-layout-refresh-project-buffers))))

(add-hook
 'buffer-list-update-hook
 #'my-layout--refresh-renamed-project-buffers)

(add-hook
 'tab-bar-tab-post-select-functions
 #'my-layout-refresh-project-buffers)

(add-hook
 'window-buffer-change-functions
 #'my-layout-refresh-project-buffers)

(add-hook 'find-file-hook #'my-layout--track-current-buffer)

(add-hook
 'after-change-major-mode-hook
 #'my-layout--track-current-buffer)

(add-hook
 'after-set-visited-file-name-hook
 #'my-layout--track-current-buffer)

(dolist (buffer (reverse (buffer-list)))
  (with-current-buffer buffer
    (my-layout--track-current-buffer 'quiet)))


;;;; Dired panel

(defvar-keymap my-layout-dired-mode-map
  :parent dired-mode-map

  "RET"
  #'my-layout-dired-open

  "<return>"
  #'my-layout-dired-open

  "^"
  #'my-layout-dired-up)

(defun my-layout--fontify-dired ()
  "Apply Dired's native faces to the current sidebar buffer."
  (font-lock-flush)
  (font-lock-ensure))

(define-minor-mode my-layout-dired-mode
  "Local behavior used by Dired sidebar buffers."
  :lighter nil
  :keymap my-layout-dired-mode-map

  (if my-layout-dired-mode
      (progn
        (my-layout-hide-sidebar-chrome)
        (font-lock-mode 1)
        (add-hook
         'dired-after-readin-hook
         #'my-layout--fontify-dired
         nil t)
        (my-layout--fontify-dired)

        ;; Refresh Dired automatically when files change.
        (auto-revert-mode 1))
    (remove-hook
     'dired-after-readin-hook
     #'my-layout--fontify-dired
     t)))

(defun my-layout-dired-buffer (project directory)
  "Return PROJECT's tab-local Dired sidebar for DIRECTORY."
  (let* ((root (project-root project))
         (directory
          (file-name-as-directory (expand-file-name directory)))
         (buffer
          (get-buffer-create
           (format " *Project Dired:%s*" (my-layout-id root))))
         (refresh nil))
    (with-current-buffer buffer
      (setq refresh
            (or (not (derived-mode-p 'dired-mode))
                (not (equal dired-directory directory))))
      (when (and refresh (bound-and-true-p auto-revert-mode))
        (auto-revert-mode -1))
      (setq default-directory directory)
      (unless (derived-mode-p 'dired-mode)
        (dired-mode directory))
      (setq dired-directory directory
            default-directory directory)
      (setq-local my-layout-project project)
      (unless my-layout-dired-mode
        (my-layout-dired-mode 1))
      (when refresh
        (dired-readin)
        (goto-char (point-min))
        (when-let* ((position (dired-initial-position directory)))
          (goto-char position)))
      (unless (bound-and-true-p auto-revert-mode)
        (auto-revert-mode 1))
      (setq dired-buffers
            (seq-remove
             (lambda (entry)
               (eq (cdr entry) buffer))
             dired-buffers)))
    buffer))

(defun my-layout-show-dired (directory)
  "Show DIRECTORY in the current Dired sidebar."
  (let ((window (selected-window))
        (project my-layout-project)
        (buffer nil))
    (unless (eq (window-parameter window 'my-layout) 'project-dired)
      (user-error "Current window is not the project Dired sidebar"))
    (setq buffer (my-layout-dired-buffer project directory))
    (set-window-dedicated-p window nil)
    (set-window-buffer window buffer)
    (set-window-dedicated-p window 'side)))

(defun my-layout-dired-open ()
  "Enter a directory or open a file in the main window."
  (interactive)
  (if (eq (window-parameter (selected-window) 'my-layout)
          'project-dired)
      (let ((file (dired-get-file-for-visit)))
        (if (file-directory-p file)
            (my-layout-show-dired file)
          (my-layout-display-main
           (find-file-noselect file))))
    (call-interactively #'dired-find-file)))

(defun my-layout-dired-up ()
  "Visit the parent directory in the Dired sidebar."
  (interactive)
  (if (eq (window-parameter (selected-window) 'my-layout)
          'project-dired)
      (my-layout-show-dired
       (file-name-directory
        (directory-file-name default-directory)))
    (call-interactively #'dired-up-directory)))


;;;; VC panel

(defconst my-layout--vc-state-codes
  '((up-to-date . " ")
    (edited . "M")
    (needs-update . "<")
    (needs-merge . "B")
    (unlocked-changes . "L")
    (added . "A")
    (removed . "D")
    (conflict . "U")
    (missing . "X")
    (ignored . "!")
    (unregistered . "?"))
  "Compact display codes for VC-Dir states.")

(defvar-keymap my-layout-vc-mode-map)

(define-key
 my-layout-vc-mode-map
 [remap vc-dir-find-file]
 #'my-layout-vc-open)

(define-minor-mode my-layout-vc-mode
  "Local behavior used by VC-Dir sidebar buffers."
  :lighter nil
  :keymap my-layout-vc-mode-map
  (when my-layout-vc-mode
    (setq-local truncate-lines t)
    (my-layout-hide-sidebar-chrome))
  (when (bound-and-true-p vc-ewoc)
    (ewoc-refresh vc-ewoc)))

(defun my-layout--vc-state-code (fileinfo)
  "Return FILEINFO's compact VC status code, or nil if unknown."
  (let ((state (vc-dir-fileinfo->state fileinfo))
        (display-state (vc-dir-fileinfo->display-state fileinfo)))
    (cond
     ((vc-dir-fileinfo->directory fileinfo) "")
     ((equal display-state "committing") "C")
     ((stringp state) "K")
     (t
      (alist-get
       (or display-state state)
       my-layout--vc-state-codes
       nil nil #'eq)))))

(defun my-layout--compact-vc-entry (start end fileinfo)
  "Compact a native Git VC-Dir FILEINFO rendered from START to END."
  (let* ((directory (vc-dir-fileinfo->directory fileinfo))
         (code (my-layout--vc-state-code fileinfo))
         (permission
          (and (>= (- end start) 25)
               (buffer-substring-no-properties
                (+ start 19) (+ start 21)))))
    (when
        (and my-layout-vc-mode
             (eq vc-dir-backend 'Git)
             code
             (= start (line-beginning-position))
             (>= (- end start) 25)
             (equal
              (buffer-substring-no-properties start (+ start 2))
              "  ")
             (equal
              (buffer-substring-no-properties (+ start 3) (+ start 5))
              "  ")
             (equal
              (buffer-substring-no-properties (+ start 17) (+ start 19))
              "  ")
             (member permission '("  " "+x" "-x"))
             (equal
              (buffer-substring-no-properties (+ start 21) (+ start 25))
              "    "))
      (let* ((state-start (+ start 5))
             (state-end (+ start 17))
             (display-code
              (propertize
               code
               'face (get-text-property state-start 'face)
               'mouse-face
               (get-text-property state-start 'mouse-face)
               'keymap (get-text-property state-start 'keymap)
               'help-echo
               (get-text-property state-start 'help-echo)))
             (inhibit-read-only t))
        (with-silent-modifications
          ;; Retain the native mark column and all logical text positions.
          (put-text-property start (+ start 2) 'display "")
          (put-text-property (+ start 3) (+ start 5) 'display " ")
          (put-text-property state-start state-end 'display display-code)
          (put-text-property
           (+ start 17) (+ start 19) 'display (if directory "" " "))
          (when (or directory (equal permission "  "))
            (put-text-property (+ start 19) (+ start 21) 'display ""))
          (put-text-property
           (+ start 21) (+ start 25)
           'display
           (if (and (not directory) (not (equal permission "  ")))
               " "
             "")))))))

(defun my-layout--compact-vc-printer (printer fileinfo)
  "Run PRINTER for FILEINFO and compact supported sidebar entries."
  (if (and my-layout-vc-mode (eq vc-dir-backend 'Git))
      (let ((start (point)))
        (prog1 (funcall printer fileinfo)
          (my-layout--compact-vc-entry start (point) fileinfo)))
    (funcall printer fileinfo)))

(unless (advice-member-p #'my-layout--compact-vc-printer 'vc-dir-printer)
  (advice-add
   'vc-dir-printer
   :around
   #'my-layout--compact-vc-printer))

(define-derived-mode
  my-layout-vc-unavailable-mode
  special-mode
  "Project-VC"
  "Major mode for projects without a VC backend."
  (setq-local truncate-lines t)
  (my-layout-hide-sidebar-chrome))

(defun my-layout-vc-open ()
  "Open the VC-Dir file at point in the main window."
  (interactive)
  (if-let* ((file (vc-dir-current-file)))
      (my-layout-display-main
       (find-file-noselect
        (expand-file-name file default-directory)))
    (user-error "No file on this line")))

(defun my-layout-vc-buffer (project)
  "Return a VC-Dir sidebar buffer for PROJECT."
  (let* ((root (project-root project))
         (backend (vc-responsible-backend root 'no-error)))
    (if backend
        (let* ((name
                (format " *Project VC:%s*" (my-layout-id root)))
               (buffer (get-buffer name)))
          (when (and buffer
                     (with-current-buffer buffer
                       (not
                        (and (derived-mode-p 'vc-dir-mode)
                             (eq vc-dir-backend backend)
                             (equal
                              (file-name-as-directory
                               (expand-file-name root))
                              (file-name-as-directory
                               (expand-file-name default-directory)))))))
            (kill-buffer buffer)
            (setq buffer nil))
          (unless buffer
            (setq buffer
                  (vc-dir-prepare-status-buffer
                   name root backend 'create-new))
            (with-current-buffer buffer
              (rename-buffer name)
              (cl-progv '(use-vc-backend) (list backend)
                (vc-dir-mode))
              (when-let* ((minor-mode
                           (intern-soft
                            (format
                             "vc-dir-%s-mode"
                             (downcase (symbol-name backend))))))
                (when (fboundp minor-mode)
                  (funcall minor-mode 1)))))
          (with-current-buffer buffer
            (setq-local my-layout-project project)
            (unless my-layout-vc-mode
              (my-layout-vc-mode 1)))
          buffer)
      (let ((buffer
             (get-buffer-create
              (format " *Project VC:%s*" (my-layout-id root)))))
        (with-current-buffer buffer
          (unless (derived-mode-p 'my-layout-vc-unavailable-mode)
            (my-layout-vc-unavailable-mode))
          (setq-local my-layout-project project
                      default-directory root)
          (let ((inhibit-read-only t))
            (erase-buffer)
            (insert "No version-control backend for this project.\n")
            (set-buffer-modified-p nil)))
        buffer))))


;;;; Left sidebar toggle

(defun my-layout--left-panel-weights ()
  "Return validated left-panel weights in display order."
  (mapcar
   (lambda (key)
     (let ((weight (alist-get key my-layout-left-panel-weights)))
       (unless (and (numberp weight) (> weight 0))
         (user-error "Invalid sidebar weight for %s" key))
       weight))
   '(buffers vc-dir dired)))

(defun my-layout-display-left-panel (buffer kind slot)
  "Display BUFFER in left side-window KIND at SLOT."
  (let ((window
         (display-buffer-in-side-window
          buffer
          `((side . left)
            (slot . ,slot)
            (window-width . ,my-layout-left-width)
            (preserve-size . (t . nil))
            (window-parameters
             . ((my-layout . ,kind)
                (no-delete-other-windows . t)))))))
    (unless window
      (error "Unable to create %s sidebar window" kind))
    (set-window-dedicated-p window 'side)
    window))

(defun my-layout--foreign-side-window (side)
  "Return a SIDE window not owned by this layout."
  (seq-find
   (lambda (window)
     (and (eq (window-parameter window 'window-side) side)
          (not (window-parameter window 'my-layout))))
   (window-list nil 'no-minibuffer)))

(defun my-layout-balance-sidebar (&optional frame)
  "Resize FRAME's three left panels according to their weights."
  (interactive)
  (unless my-layout--resizing
    (let* ((my-layout--resizing t)
           (windows
            (mapcar
             (lambda (kind)
               (my-layout-window kind frame))
             my-layout--left-panel-kinds)))
      (when (seq-every-p #'window-live-p windows)
        (let* ((weights (my-layout--left-panel-weights))
               (weight-total (apply #'+ weights))
               (height-total
                (apply #'+ (mapcar #'window-total-height windows)))
               (weight-used 0)
               (height-used 0)
               (targets
                (mapcar
                 (lambda (weight)
                   (setq weight-used (+ weight-used weight))
                   (let ((edge
                          (round
                           (* height-total
                              (/ (float weight-used) weight-total)))))
                     (prog1 (- edge height-used)
                       (setq height-used edge))))
                 weights)))
          (cl-mapc
           (lambda (window target)
             (let ((delta (- target (window-total-height window))))
               (unless (zerop delta)
                 (condition-case nil
                     (window-resize window delta nil 'safe)
                   (error nil)))))
           (butlast windows)
           (butlast targets)))))))

(defun my-layout--balance-sidebar-after-resize (frame)
  "Rebalance FRAME's sidebar after a window size change."
  (condition-case nil
      (my-layout-balance-sidebar frame)
    (user-error nil)))

(add-hook
 'window-size-change-functions
 #'my-layout--balance-sidebar-after-resize)

(defun my-layout-toggle-sidebar ()
  "Toggle project buffers, VC-Dir, and Dired in the left sidebar.

This affects only the currently selected Emacs tab."
  (interactive)
  (if (seq-some #'my-layout-window my-layout--left-panel-kinds)
      (dolist (kind my-layout--left-panel-kinds)
        (my-layout-delete-window kind))
    (let* ((origin (selected-window))
           (project (project-current nil)))
      (unless project
        (user-error "Current buffer is not inside a project"))
      (when-let* ((window (my-layout--foreign-side-window 'left)))
        (user-error
         "Left sidebar is already used by %s"
         (buffer-name (window-buffer window))))
      (my-layout--left-panel-weights)
      (let* ((root
               (project-root project))
              (buffers
               (my-layout-project-buffer project))
              (vc
               (my-layout-vc-buffer project))
              (dired
               (my-layout-dired-buffer project root)))
        (let ((created-windows nil))
          (condition-case error-data
              (progn
                (push
                 (my-layout-display-left-panel
                  buffers 'project-buffers -1)
                 created-windows)
                (push
                 (my-layout-display-left-panel
                  vc 'project-vc 0)
                 created-windows)
                (push
                 (my-layout-display-left-panel
                  dired 'project-dired 1)
                 created-windows)
                (unless
                    (= (length
                        (delete-dups
                         (copy-sequence created-windows)))
                       3)
                  (error "Frame is too small for three sidebar panels"))
                (my-layout-balance-sidebar)
                (select-window origin))
            (error
             (dolist (window (delete-dups created-windows))
               (when (window-live-p window)
                 (set-window-dedicated-p window nil)
                 (delete-window window)))
             (when (window-live-p origin)
               (select-window origin))
             (signal (car error-data) (cdr error-data)))))))))


;;;; Numbered navigation

(defun my-layout--key-number ()
  "Return the numeric value of the key that invoked this command."
  (let ((event (event-basic-type last-command-event)))
    (when (and (integerp event) (>= event ?0) (<= event ?9))
      (- event ?0))))

(defun my-layout-switch-project-buffer (&optional number)
  "Switch to project buffer NUMBER in the main window."
  (interactive
   (list
    (or (my-layout--key-number)
        (read-number "Project buffer number: "))))
  (unless (and (integerp number) (> number 0))
    (user-error "Buffer number must be positive"))
  (let* ((project (my-layout-current-project))
         (buffers
          (and project
               (my-layout-ordered-project-buffers project)))
         (buffer (nth (1- number) buffers)))
    (unless project
      (user-error "Current buffer is not inside a project"))
    (unless buffer
      (user-error "No project buffer numbered %d" number))
    (my-layout-display-main buffer)))

(defun my-layout-switch-recent-project-buffer ()
  "Switch to the previously displayed project file buffer."
  (interactive)
  (let* ((project (my-layout-current-project))
         (window (my-layout-main-window))
         (buffers
          (and project
               (my-layout-ordered-project-buffers project)))
         (buffer
          (and window
               (seq-some
                (lambda (entry)
                  (let ((candidate (car entry)))
                    (and (memq candidate buffers) candidate)))
                (window-prev-buffers window)))))
    (unless project
      (user-error "Current buffer is not inside a project"))
    (unless buffer
      (user-error "No previous project buffer"))
    (my-layout-display-main buffer)))

(defun my-layout-select-tab (&optional number)
  "Select tab NUMBER."
  (interactive
   (list
    (or (my-layout--key-number)
        (read-number "Tab number: "))))
  (tab-bar-select-tab number))


;;;; ANSI terminal creation

(defun my-layout-term-buffer (role command)
  "Return a live tab-local ANSI terminal.

ROLE identifies the terminal, and COMMAND is the program it runs."
  (let* ((root
          (my-layout-project-root))

         (name
          (format
           "Layout %s:%s"
           role
           (my-layout-id root)))

         (buffer
          (get-buffer
           (format "*%s*" name))))

    ;; Reuse a live process. If the old process exited, replace it.
    (unless
        (and buffer
             (process-live-p
              (get-buffer-process buffer)))

      (when buffer
        (kill-buffer buffer))

      (let ((default-directory root))
        (setq buffer
              (save-window-excursion
                (ansi-term command name))))

      (with-current-buffer buffer
        (my-layout-hide-top-lines)))

    buffer))

(defun my-layout-toggle-terminal
    (kind role command side size-key size preserve-size)
  "Toggle a custom ANSI terminal side window."
  (if (my-layout-window kind)

      ;; Hiding the window does not kill its terminal process.
      (my-layout-delete-window kind)

    (when-let* ((window (my-layout--foreign-side-window side)))
      (user-error
       "%s side is already used by %s"
       side
       (buffer-name (window-buffer window))))
    (let* ((buffer
             (my-layout-term-buffer role command))

           (window
            (display-buffer-in-side-window
             buffer
             `((side . ,side)
               (slot . 0)
               (,size-key . ,size)
               (preserve-size . ,preserve-size)
               (window-parameters
                . ((my-layout . ,kind)
                   (no-delete-other-windows . t)))))))

      (unless window
        (error "Unable to create %s terminal window" role))
      (set-window-dedicated-p window 'side)
      (select-window window))))


;;;; Bottom terminal

(defun my-layout-toggle-bottom-terminal ()
  "Toggle the bottom one-third-height ANSI terminal."
  (interactive)

  (my-layout-toggle-terminal
   'bottom-term
   "Bottom"
   my-layout-shell
   'top
   'window-height
   my-layout-bottom-height
   '(nil . t)))


;;;; Right agent terminal

(defun my-layout-toggle-agent-terminal ()
  "Toggle the right full-height ANSI agent terminal."
  (interactive)

  (my-layout-toggle-terminal
   'agent-term
   "Agent"
   my-layout-agent-command
   'right
   'window-width
   my-layout-agent-width
   '(t . nil)))


;;;; Keybindings

(defun my-layout--bind-key (key command)
  "Bind KEY to COMMAND globally and in both ANSI terminal modes."
  (dolist (map (list global-map term-mode-map term-raw-map))
    (define-key map (kbd key) command)))

(dolist (binding
         '(("<f5>" . my-layout-toggle-bottom-terminal)
           ("<f7>" . my-layout-toggle-agent-terminal)
           ("<f6>" . my-layout-toggle-sidebar)))
  (my-layout--bind-key (car binding) (cdr binding)))

(dotimes (index 9)
  (let ((number (1+ index)))
    (my-layout--bind-key (format "M-%d" number) #'my-layout-switch-project-buffer)
    (my-layout--bind-key (format "C-c %d" number) #'my-layout-select-tab)))
(my-layout--bind-key "M-0" #'my-layout-switch-recent-project-buffer)
(my-layout--bind-key "C-c 0" #'tab-bar-switch-to-recent-tab)


(provide 'my-editor)

;;; my-editor.el ends here
