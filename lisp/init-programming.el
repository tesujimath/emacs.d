;;; init-programming --- setup programming modes

;;; Commentary:

;;; Code:

;; Structured editing
(use-package smartparens
  :hook ((prog-mode . smartparens-mode)
         (prog-mode . smartparens-strict-mode))
  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings)
  (keymap-set smartparens-mode-map "M-s" nil))  ; key-clash with my consult bindings

(use-package eglot
  :ensure nil  ; built-in since Emacs 29
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil)
  ;; Keep eglot from being too eager — helps responsiveness
  (eglot-events-buffer-size 0)         ; disable events logging
  (eglot-sync-connect nil)             ; don't block on connect
  )

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)
              ("C-c ! l" . flymake-show-buffer-diagnostics)))

(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(provide 'init-programming)
;;; init-programming.el ends here
