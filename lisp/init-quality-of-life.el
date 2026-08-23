;;; init-quality-of-life --- setup quality-of-life improvements  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; ace-window selection
(use-package ace-window
  :bind ("M-o" . ace-window)
  :config
  (set-face-attribute 'aw-leading-char-face nil
                      :height 300    ; 3x normal size
                      :weight 'bold))

;; Whitespace handling
(setq-default indent-tabs-mode nil)
(use-package whitespace
  :ensure nil
  :custom
  (whitespace-style '(face tabs tab-mark trailing))
  :hook (prog-mode . whitespace-mode)
  (before-save-hook . whitespace-cleanup))

;; Visual guides
(use-package which-key
  :ensure nil
  :init (which-key-mode)
  :custom (which-key-idle-delay 0.5))

;; Appearance
(use-package emacs
  :ensure nil
  :config
  (load-theme 'wombat :no-confirm)
  (set-face-attribute 'default nil :family "SF Mono" :foundry "nil" :slant 'normal :weight 'medium :height 100 :width 'normal)
  (display-time-mode 1)
  :custom
  (fill-column 120))
(setq-default line-spacing 0.1)

;; silence
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; Better modeline
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  (column-number-mode 1)
  :custom
  (doom-modeline-time t)
  :config
  (set-face-attribute 'mode-line nil :height 120)
  (set-face-attribute 'mode-line-inactive nil :height 120))
;; doom-modeline requires nerd-icons
(use-package nerd-icons)

;;; macOS tweaks
(when (eq system-type 'darwin)
  ;; macOS keybinding for fullscreen
  (keymap-global-set "C-s-f" #'toggle-frame-fullscreen)

  ;; use non-native fullscreen, so Emacs stays in the main space and popup frames don't cause space transitions
  (setq ns-use-native-fullscreen nil)

  ;; use open instead of the default which seems to be xdg-open
  (setq dired-guess-shell-alist-user '((".*" "open"))))

;; make the delete key sane
(delete-selection-mode 1)

;; confirm exit
(setq confirm-kill-emacs 'yes-or-no-p)

;; no backup files thanks
(setq make-backup-files nil)

(provide 'init-quality-of-life)
;;; init-quality-of-life.el ends here
