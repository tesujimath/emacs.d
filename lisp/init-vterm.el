;;; init-vterm --- setup vterm  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package vterm
  :ensure nil  ; install via Nix — has native compiled component
  :custom
  (vterm-shell (executable-find "fish"))
  (vterm-buffer-name-string "vterm %s")
  :bind ("C-c t" . vterm))

(provide 'init-vterm)
;;; init-vterm.el ends here
