;;; init-actions --- setup embark and related actions  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package embark
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings))
  :hook (embark-collect-mode . consult-preview-at-point-mode)
  :custom
  (prefix-help-command #'embark-prefix-help-command))

;; A bare `use-package' loads eagerly, which pulled in both embark and consult
;; during startup.  :after is this package's intended recipe.
(use-package embark-consult
  :after (embark consult))

;; wgrep's autoloads already put `wgrep-setup' on `grep-setup-hook', so it
;; loads by itself the first time a grep buffer appears.
(use-package wgrep
  :defer t
  :custom (wgrep-auto-save-buffer t))

(provide 'init-actions)
;;; init-actions.el ends here
