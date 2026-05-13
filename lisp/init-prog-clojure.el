;;; init-prog-clojure --- setup Clojure  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package clojure-ts-mode
  :hook (((clojure-mode clojure-ts-mode) . eglot-ensure)))

(with-eval-after-load 'apheleia
  (dolist (mode '(clojure-mode clojure-ts-mode))
    (setf (alist-get mode apheleia-mode-alist) 'zprint))
  ;; Clojure autoformat using zprint
  ;; zprint -c: read config from project if present
  (setf (alist-get 'zprint apheleia-formatters) '("zprint" "{:fn-map {\"f/attempt-all\" :binding, \"prop/for-all\" :binding}}")))

(use-package cider :defer t
  :hook ((cider-repl-mode . smartparens-mode)
         (cider-repl-mode . smartparens-strict-mode)))

(provide 'init-prog-clojure)
;;; init-prog-clojure.el ends here
