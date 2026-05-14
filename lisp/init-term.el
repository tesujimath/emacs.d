;;; init-term --- setup terminal  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package vterm
  :ensure nil  ; install via Nix — has native compiled component
  :custom
  (vterm-shell (executable-find "fish"))
  :bind ("C-c t" . vterm))

(provide 'init-term)
;;; init-term.el ends here
