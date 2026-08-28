;;; init-ai-agent-shell --- setup agent-shell  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package agent-shell
  :custom
  ;; https://github.com/xenodium/agent-shell#anthropic-claude
  (agent-shell-anthropic-authentication (agent-shell-anthropic-make-authentication :login t))
  (agent-shell-cursor-acp-command '("cursor-agent" "acp"))

  :bind (:map agent-shell-mode-map
              ("C-c C-f" . agent-shell-prompt-compose)))

(provide 'init-ai-agent-shell)
;;; init-ai-agent-shell.el ends here
