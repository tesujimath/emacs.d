;;; init-programming --- setup programming modes

;;; Commentary:

;;; Code:

;; Structured editing
(use-package smartparens
  :hook ((prog-mode . smartparens-mode)
         (prog-mode . smartparens-strict-mode))
  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings))

;; (use-package eglot
;;   :ensure nil  ; built-in since Emacs 29
;;   :hook ((python-ts-mode . eglot-ensure)
;;          (js-ts-mode     . eglot-ensure)
;;          (tsx-ts-mode    . eglot-ensure))
;;   :custom
;;   (eglot-autoshutdown t)
;;   (eglot-confirm-server-initiated-edits nil))

;; (use-package treesit-auto
;;   :custom (treesit-auto-install 'prompt)
;;   :config (global-treesit-auto-mode))

(provide 'init-programming)
;;; init-programming.el ends here
