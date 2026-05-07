;;; init-clojure --- setup Clojure

;;; Commentary:

;;; Code:

(use-package clojure-mode
  :after (apheleia eglot)
  :config
  ;; Clojure autoformat using zprint
  ;; zprint -c: read config from project if present
  (setf (alist-get 'clojure-mode apheleia-mode-alist) 'zprint
        (alist-get 'zprint apheleia-formatters) '("zprint" "{:fn-map {\"f/attempt-all\" :binding, \"prop/for-all\" :binding}}")))

(use-package clojure-ts-mode :after (clojure-mode treesit-auto)
  :config
  (setf (alist-get 'clojure-ts-mode apheleia-mode-alist) 'zprint)
  :hook (((clojure-mode clojure-ts-mode) . eglot-ensure)))

(use-package flycheck-clj-kondo)

(use-package cider :defer t
  :hook ((cider-repl-mode . smartparens-mode)
         (cider-repl-mode . smartparens-strict-mode)))

(provide 'init-clojure)
;;; init-clojure.el ends here
