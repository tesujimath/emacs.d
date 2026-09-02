;;; init-undo --- setup undo  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package undo-fu
  :bind (("C-_" . undo-fu-only-undo)
         ("C-?" . undo-fu-only-redo)))

(use-package undo-fu-session
  :config (undo-fu-session-global-mode))

(use-package vundo
  :bind ("C-x u" . vundo))

(provide 'init-undo)
;;; init-undo.el ends here
