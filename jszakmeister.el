; Turn off the visible bell
(setq visible-bell nil)

; Change the background color for current line
(require 'hl-line)
(set-face-background 'hl-line "#111")

; Customize the highlighting of parens.  The default was to confusing
; to look at.
(setq hl-paren-colors '("DarkOrange1" "firebrick3" "firebrick4" "IndianRed4"))

(add-hook 'clojure-mode-hook
          '(lambda ()
             (highlight-parentheses-mode)
             (setq autopair-handle-action-fns
                   (list 'autopair-default-handle-action
                         '(lambda (action pair pos-before)
                            (hl-paren-color-update))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Taken from Tim's emacs config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Set colors for dark background
(add-to-list 'default-frame-alist '(cursor-color . "#ff0000"))
(add-to-list 'default-frame-alist '(foreground-color . "lightgrey"))
(add-to-list 'default-frame-alist '(background-color . "black"))

;;;; Set focus follows mouse
(setq focus-follows-mouse t)

;;;; Windows printer setup example
;; (setq printer-name "//xxx/name")
;; (setq ps-printer-name "//xxx/name")

;;;; Enable headers (requires pr)
;; (setq lpr-header-switches t)

;;;; Proper color printing with dark backgrounds
(require 'my-print)

;;;; Tag customization and bindings
(require 'my-tags)

;;;; Default to indent with spaces, not tabs
(setq-default indent-tabs-mode nil)

;;;; Show trailing whitespace
(setq-default show-trailing-whitespace t)

;;;; Desktop saving
;; Load a desktop file if it exists
(desktop-save-mode t)
;; Disable desktop save mode if no file was found
;; This keeps desktops from being saved without explicitly
;; calling desktop-save somewhere first
(defun my-desktop-no-desktop-file-hook ()
  (desktop-save-mode 0))
(add-hook 'desktop-no-desktop-file-hook 'my-desktop-no-desktop-file-hook)

;;;; Set default mode line appearance
;; Move function display before mode display
(setq default-mode-line-format
      '("-"
	mode-line-mule-info
	mode-line-modified
	mode-line-frame-identification
	mode-line-buffer-identification
	"  "
	mode-line-position
	(vc-mode vc-mode)
	"  "
	(which-func-mode ("" which-func-format "--"))
	mode-line-modes
	(global-mode-string ("--" global-mode-string))
	"-%-"))

;; Show which function name in mode line
(which-function-mode t)

;; Enable column numbers
(column-number-mode t)

;;;; Enable Python for SCons files
(add-to-list 'auto-mode-alist '("Scons\\(cript\\|truct\\)" . python-mode))

(setq starter-kit-packages
      (append starter-kit-packages (list 'haml-mode
                                         'sass-mode
                                         'color-theme
                                         'highlight-80+
                                         'json
                                         'lusty-explorer
                                         'markdown-mode
                                         'org)))

(starter-kit-elpa-install)

;; Load some plugins
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

;; Load my color theme
(require 'color-theme)
(autoload 'color-theme-empty-void "empty-void-theme" "" t nil)

;; Don't clutter up directories with files~
(setq auto-save-file-name-transforms
      `((".*"
         ,(expand-file-name (concat dotfiles-dir "saves")) t)))

;; Don't soft-wrap lines
(setq-default truncate-lines t)

;; Bring in the better ido fuzzy matcher
(require 'better-ido-matching)

