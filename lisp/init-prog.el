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

;; ensure ' doesn't give us paired quotes in minibuffer
;; the depth 100 forces it to run after other stuff
(add-hook 'eval-expression-minibuffer-setup-hook
          (lambda () (smartparens-mode -1))
          100)

(use-package eglot
  ;; we need at least eglot 1.20 for pull diagnostics, for tsgo and roslyn-ls,
  ;; so until that version is built-in (probably coming in Emacs 31):
  :ensure (:host github :repo "emacs-mirror/emacs" :branch "master" :files ("lisp/progmodes/eglot.el"))
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil)
  ;; Keep eglot from being too eager — helps responsiveness
  (eglot-events-buffer-config '(:size 0))  ; disable events logging
  (eglot-sync-connect nil)                 ; don't block on connect
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider)) ; don't use LSP for formatting, we're using Apheleia
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

(use-package treesit-fold)

;; programming-related modes
(require 'init-prog-bash)
(require 'init-prog-bicep)
(require 'init-prog-clojure)
(require 'init-prog-csharp)
(require 'init-prog-fennel)
(require 'init-prog-fish)
(require 'init-prog-fsharp)
(require 'init-prog-nix)
(require 'init-prog-python)
(require 'init-prog-rust)
(require 'init-prog-typescript)


(provide 'init-prog)
;;; init-prog.el ends here
