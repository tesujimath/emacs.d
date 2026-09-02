;;; init-env --- setup environment  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; TODO: resolve.  `exec-path-from-shell-initialize' spawns a login shell on
;; every startup, which is the largest remaining cost now that packages are
;; deferred: measured around 0.25s warm and 2.8s cold for one `zsh -l -i'.
;; Since we only extract PATH and __NIX_DARWIN_SET_ENVIRONMENT_DONE, and
;; nix-darwin makes those stable between rebuilds, the value could be cached to
;; a file and reused.  The risk is a stale cache after a rebuild, which shows up
;; as language servers quietly failing to launch, so any cache wants
;; invalidating off the nix profile's mtime rather than needing a manual
;; refresh.  The alternative is to drop this entirely and have Home Manager
;; generate a static `setenv'/`exec-path' form.
;;
;; Note also that the `window-system' guard below means a daemon gets no PATH
;; fixup at all, so this silently stops running if we ever move to
;; `emacs --daemon'.
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
