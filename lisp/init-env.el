;;; init-env --- setup environment  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package exec-path-from-shell
  :config
  ;; macOS launcher doesn't give us a good environment
  (when (memq window-system '(mac ns x))
    (setq exec-path-from-shell-variables
          ;; we need both of these to avoid path reset from nrepl server
          '("PATH" "__NIX_DARWIN_SET_ENVIRONMENT_DONE"
            ;; these from exec-path-from-shell README:
            ;; "SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "NIX_SSL_CERT_FILE" "NIX_PATH"
            ))
    (exec-path-from-shell-initialize))
  )

(provide 'init-env)
;;; init-env.el ends here
