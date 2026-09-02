;;; init-envrc --- setup envrc  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defun tesujimath/maybe-enable-envrc-global-mode ()
  "Enable `envrc-global-mode' if `direnv' is installed."
  (when (executable-find "direnv")
    (envrc-global-mode)))

(use-package envrc
  :bind-keymap ("C-c e" . envrc-command-map))

;; Having this inside the use-package didn't set it up correctly:
;; :hook (after-init . tesujimath/maybe-enable-envrc-global-mode)
;; `envrc-global-mode' is an autoload, so no `elpaca-wait' barrier is needed
;; here; elpaca-after-init-hook runs once the install queues have drained.
(add-hook 'elpaca-after-init-hook #'tesujimath/maybe-enable-envrc-global-mode)

(provide 'init-envrc)
;;; init-envrc.el ends here
