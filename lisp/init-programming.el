;;; init-programming --- setup programming modes

;;; Commentary:

;;; Code:

;; Structured editing
(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config (require 'smartparens-config))

;; (defun tesujimath/prog-mode-defaults ()
;;   "Default coding hook, useful with any programming language."
;;   (smartparens-mode +1))

;; (defvar tesujimath/prog-mode-hook 'tesujimath/prog-mode-defaults)

;; (add-hook 'prog-mode-hook (lambda () (run-hooks 'tesujimath/prog-mode-hook)))

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
