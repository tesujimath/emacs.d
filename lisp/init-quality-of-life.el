;;; init-quality-of-life --- setup quality-of-life improvements

;;; Commentary:

;;; Code:

;; Better undo
(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package undo-fu-session
  :config (undo-fu-session-global-mode))

;; Visual guides
(use-package which-key
  :init (which-key-mode)
  :custom (which-key-idle-delay 0.5))

;; Theme
(use-package modus-themes          ; built into Emacs 28+, just configure
  :ensure nil
  :config (load-theme 'modus-vivendi-tinted :no-confirm))

;; Better modeline
(use-package doom-modeline
  :init (doom-modeline-mode))

(provide 'init-quality-of-life)
;;; init-quality-of-life.el ends here
