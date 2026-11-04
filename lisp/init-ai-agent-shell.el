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
              ("C-c C-f" . agent-shell-prompt-compose))

  :config
  (add-to-list 'agent-shell-agent-configs #'tesujimath/agent-shell-dirge-make-agent-config t))

(defvar tesujimath/agent-shell-dirge-acp-command '("dirge" "--acp")
  "Command and parameters for the dirge ACP client.")

(defun tesujimath/agent-shell-dirge-make-agent-config ()
  "Create a dirge coding agent configuration."
  (agent-shell-make-agent-config
   :identifier 'dirge
   :mode-line-name "Dirge"
   :buffer-name "Dirge"
   :shell-prompt "Dirge> "
   :shell-prompt-regexp "Dirge> "
   :client-maker (lambda (buffer)
                   (agent-shell--make-acp-client
                    :command (car tesujimath/agent-shell-dirge-acp-command)
                    :command-params (cdr tesujimath/agent-shell-dirge-acp-command)
                    :context-buffer buffer))
   :install-instructions "Install dirge and make sure it is on `exec-path'."))

(defun tesujimath/agent-shell-dirge-start-agent ()
  "Start an interactive dirge agent shell."
  (interactive)
  (agent-shell--dwim :config (tesujimath/agent-shell-dirge-make-agent-config)
                     :new-shell t))

(use-package agent-recall
  :config
  (setq agent-recall-search-paths '("~/vc/smartly" "~/.emacs.d" "~/home.nix" "~/home.modules.nix" "~/home.modules.datacom.nix" "~/chat"))
  (setq agent-recall-search-function 'consult-ripgrep)
  (setq agent-recall-browse-sort 'modified-desc))

(provide 'init-ai-agent-shell)
;;; init-ai-agent-shell.el ends here
