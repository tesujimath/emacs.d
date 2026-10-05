;;; init-ai-agent-shell --- setup agent-shell  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package agent-shell
  :custom
  ;; https://github.com/xenodium/agent-shell#anthropic-claude
  (agent-shell-anthropic-authentication (agent-shell-anthropic-make-authentication :login t))
  (agent-shell-cursor-acp-command '("cursor-agent" "acp"))
  (agent-shell-anthropic-default-session-mode-id "auto")
  ;; Only pull in context from an explicit selection, not dired point or current line.
  (agent-shell-context-sources '(region))

  :hook
  ((agent-shell-mode-hook . agent-recall-track-sessions))

  :bind (:map agent-shell-mode-map
              ("C-c C-f" . agent-shell-prompt-compose)))

(use-package agent-recall
  :config
  (setq agent-recall-search-paths '("~/vc/smartly" "~/.emacs.d" "~/home.nix" "~/home.modules.nix" "~/home.modules.datacom.nix" "~/chat"))
  (setq agent-recall-search-function 'consult-ripgrep)
  (setq agent-recall-browse-sort 'modified-desc))

(provide 'init-ai-agent-shell)
;;; init-ai-agent-shell.el ends here
