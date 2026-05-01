;;; init-quality-of-life --- setup quality-of-life improvements

;;; Commentary:

;;; Code:

;; Whitespace handling
(setq-default indent-tabs-mode nil)
(use-package whitespace
  :ensure nil
  :custom
  (whitespace-style '(face tabs tab-mark trailing))
  :hook (prog-mode . whitespace-mode)
  (before-save-hook . whitespace-cleanup))

;; Better undo
;; (use-package undo-fu
;;   :config
;;   (global-unset-key (kbd "C-z"))
;;   (global-set-key (kbd "C-z")   'undo-fu-only-undo)
;;   (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

;; (use-package undo-fu-session
;;   :config (undo-fu-session-global-mode))

;; Visual guides
;; (use-package which-key
;;   :init (which-key-mode)
;;   :custom (which-key-idle-delay 0.5))

;; Appearance
(use-package emacs
  :ensure nil
  :config
  (load-theme 'wombat :no-confirm)
  (set-face-attribute 'default nil :family "SF Mono" :foundry "nil" :slant 'normal :weight 'medium :height 100 :width 'normal))
(setq-default line-spacing 0.1)

;; see https://protesilaos.com/emacs/ef-themes-pictures
;; (use-package ef-themes
;;   :config
;;   (load-theme 'ef-dark :no-confirm))

;; Better modeline
;; (use-package doom-modeline
;;   :init (doom-modeline-mode))


(provide 'init-quality-of-life)
;;; init-quality-of-life.el ends here
