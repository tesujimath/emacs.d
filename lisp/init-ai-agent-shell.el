;;; init-ai-agent-shell --- setup agent-shell  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package agent-shell
  :config
  ;; https://github.com/xenodium/agent-shell#anthropic-claude
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t)))

(provide 'init-ai-agent-shell)
;;; init-ai-agent-shell.el ends here
