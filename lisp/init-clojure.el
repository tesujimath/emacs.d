;;; init-clojure --- setup Clojure

;;; Commentary:

;;; Code:

(defun tesujimath/lint-clj-project ()
  "Run clj-kondo --lint on the project and show results in a compilation buffer."
  (interactive)
  (let* ((default-directory (locate-dominating-file default-directory "deps.edn")))
    (compile "clj-kondo --lint src test")))

(defun tesujimath/clojure-mode-defaults ()
  (setq cljr-warn-on-eval nil)                   ; don't warn when doing refactoring
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (keymap-local-set "C-c `" #'tesujimath/lint-clj-project))

(use-package clojure-mode
  :after (apheleia eglot)
  :config
  ;; Clojure autoformat using zprint
  ;; zprint -c: read config from project if present
  (setf (alist-get 'zprint apheleia-formatters) '("zprint" "{:fn-map {\"f/attempt-all\" :binding, \"prop/for-all\" :binding}}")
        (alist-get 'clojure-mode apheleia-mode-alist) 'zprint))

(use-package clojure-ts-mode :after (clojure-mode treesit-auto)
  :config
  (setf (alist-get 'clojure-ts-mode apheleia-mode-alist) 'zprint)
  :hook (((clojure-mode clojure-ts-mode) . tesujimath/clojure-mode-defaults)
         ((clojure-mode clojure-ts-mode) . eglot-ensure)))

(use-package clj-refactor)
(use-package flycheck-clj-kondo)

(use-package cider :defer t :after smartparens
  :hook ((cider-repl-mode . smartparens-mode)
         (cider-repl-mode . smartparens-strict-mode)))

(provide 'init-clojure)
;;; init-clojure.el ends here
