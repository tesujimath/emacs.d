;;; init-programming --- setup programming modes

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure nil  ; built-in since Emacs 29
  :hook ((python-ts-mode . eglot-ensure)
         (js-ts-mode     . eglot-ensure)
         (tsx-ts-mode    . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil))

;; If you prefer lsp-mode over eglot:
;; (use-package lsp-mode
;;   :commands lsp
;;   :custom
;;   (lsp-completion-provider :none)  ; let corfu handle it
;;   (lsp-keymap-prefix "C-c l"))

(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config (global-treesit-auto-mode))

(provide 'init-programming)
;;; init-programming.el ends here
