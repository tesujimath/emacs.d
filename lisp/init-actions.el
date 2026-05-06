;;; init-actions --- setup embark and related actions

;;; Commentary:

;;; Code:

(use-package embark
  :after consult
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings))
  :hook (embark-collect-mode . consult-preview-at-point-mode)
  :custom
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult)

(use-package wgrep
  :custom (wgrep-auto-save-buffer t))

(provide 'init-actions)
;;; init-actions.el ends here
