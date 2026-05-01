;;; init-envrc --- setup envrc

;;; Commentary:

;;; Code:

(defun tesujimath/maybe-enable-envrc-global-mode ()
  "Enable `envrc-global-mode' if `direnv' is installed."
  (when (executable-find "direnv")
    (envrc-global-mode)))

(use-package envrc
  :bind-keymap ("C-c e" . envrc-command-map))

;; having this inside the use-package didn't set it up correctly
;; :hook (after-init . tesujimath/maybe-enable-envrc-global-mode)
(elpaca-wait)
(add-hook 'after-init-hook #'tesujimath/maybe-enable-envrc-global-mode)

(provide 'init-envrc)
;;; init-envrc.el ends here
