;;; init-prog --- setup prog modes  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Structured editing
(use-package smartparens
  :hook (((prog-mode eval-expression-minibuffer-setup) . smartparens-mode)
         ((prog-mode eval-expression-minibuffer-setup) . smartparens-strict-mode))
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
  (eglot-events-buffer-config '(:size 0))  ; disable events logging
  (eglot-sync-connect nil)                 ; don't block on connect
  :bind (:map eglot-mode-map
              ;; Refactoring
              ("C-c r r" . eglot-rename)
              ("C-c r f" . eglot-format)
              ("C-c r F" . eglot-format-buffer)
              ("C-c r a" . eglot-code-actions)
              ("C-c r o" . eglot-code-action-organize-imports)
              ("C-c r q" . eglot-code-action-quickfix)
              ("C-c r e" . eglot-code-action-extract)
              ("C-c r i" . eglot-code-action-inline)
              ("C-c r w" . eglot-code-action-rewrite)
              ;; Navigation
              ("C-c r d" . eglot-find-declaration)
              ("C-c r i" . eglot-find-implementation)
              ("C-c r t" . eglot-find-typeDefinition)
              ("C-c r u" . xref-find-references)
              ;; Docs
              ("C-c r h" . eldoc)))

(use-package eglot-booster
  :ensure (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config (eglot-booster-mode))

(use-package consult-eglot
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c r S" . consult-eglot-symbols)))

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)
              ("C-c r x" . flymake-show-project-diagnostics)
              ("C-c r X" . flymake-show-buffer-diagnostics)))

(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; programming-related modes
(require 'init-prog-bash)
(require 'init-prog-clojure)
(require 'init-prog-fennel)
(require 'init-prog-fsharp)
(require 'init-prog-nix)
(require 'init-prog-python)
(require 'init-prog-rust)


(provide 'init-prog)
;;; init-prog.el ends here
