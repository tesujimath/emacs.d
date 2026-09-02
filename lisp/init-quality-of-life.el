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
;;
;; TODO: resolve.  `whitespace-cleanup' on the global `before-save-hook' cleans
;; every file we save, not just our own.  Since `whitespace-style' includes
;; tabs, that untabifies as well as stripping trailing space, which makes
;; unrelated diffs in other people's repos and is destructive in files where
;; tabs are significant, eg Makefiles.  It also overlaps with apheleia, which
;; already formats on save for most languages we use.
;;
;; The candidate fix is purcell's whitespace-cleanup-mode: a buffer-local minor
;; mode which cleans on save only if the buffer was already clean when opened,
;; judged using our own `whitespace-style', so tab-significant files are never
;; touched.  It is settable from .dir-locals.el, which is the right home for a
;; per-repo whitespace policy.  Two things to check first: it tests cleanliness
;; by copying the whole buffer at mode-enable time, so measure the cost on a
;; large file before enabling it globally, and it still uses old-style defadvice.
;; The alternative needing no new package is a buffer-local hook in the modes we
;; own.
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

;; Session state.  recentf also backs `consult-buffer''s recent-file source.
(use-package recentf
  :ensure nil
  :init (recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-exclude '("/elpaca/" "/\\.git/")))

(use-package saveplace
  :ensure nil
  :init (save-place-mode))

;; Appearance
(defvar my/default-font
  (cond ((eq system-type 'darwin) "SF Mono")
        ((eq system-type 'windows-nt) "Consolas")
        (t "Monospace")))

(use-package emacs
  :ensure nil
  :config
  (load-theme 'wombat :no-confirm)
  (set-face-attribute 'default nil :family my/default-font :foundry "nil" :slant 'normal :weight 'medium :height 100 :width 'normal)
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

;;; Windows tweaks
(when (eq system-type 'windows-nt)
  ;; Windows in a VM using RDP-mounted directory doesn't support notify
  (setq auto-revert-use-notify nil)
  (global-auto-revert-mode 1))

;; make the delete key sane
(delete-selection-mode 1)

;; confirm exit
(setq confirm-kill-emacs 'yes-or-no-p)

;; no backup files thanks
(setq make-backup-files nil)

(provide 'init-quality-of-life)
;;; init-quality-of-life.el ends here
