;;; init-env --- setup environment

;;; Commentary:

;;; Code:

(use-package exec-path-from-shell
  :config
  ;; macOS launcher doesn't give us a good environment
  (when (memq window-system '(mac ns x))
    (setq exec-path-from-shell-variables
          ;; we need both of these to avoid path reset from nrepl server
          '("PATH" "__NIX_DARWIN_SET_ENVIRONMENT_DONE"))
    (exec-path-from-shell-initialize))
  )

(provide 'init-env)
;;; init-env.el ends here
