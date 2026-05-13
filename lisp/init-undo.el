;;; init-undo --- setup undo  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package undo-fu
  :config
  (global-set-key (kbd "C-_") #'undo-fu-only-undo)
  (global-set-key (kbd "C-?") #'undo-fu-only-redo))

(use-package undo-fu-session
  :config (undo-fu-session-global-mode))

(use-package vundo
  :bind ("C-x u" . vundo))

(provide 'init-undo)
;;; init-undo.el ends here
