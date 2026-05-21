;;; init-prog-clojure --- setup Clojure  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package clojure-ts-mode
  :hook ((clojure-ts-mode . eglot-ensure))
  :custom
  (clojure-ts-docstring-fill-column 120))

(with-eval-after-load 'apheleia
  (dolist (mode '(clojure-mode clojure-ts-mode))
    (setf (alist-get mode apheleia-mode-alist) 'zprint))
  ;; Clojure autoformat using zprint
  ;; zprint -c: read config from project if present
  (setf (alist-get 'zprint apheleia-formatters) '("zprint" "{:fn-map {\"f/attempt-all\" :binding, \"prop/for-all\" :binding}}")))

(defun tesujimath/clojure-ts-insert-ns-new-file ()
  "Insert namespace form for new Clojure files."
  (when (and (buffer-file-name)
             (= (point-min) (point-max)))
    (clojure-ts-insert-ns-form)
    (insert "\n\n")))

(add-hook 'clojure-ts-mode-hook #'tesujimath/clojure-ts-insert-ns-new-file)

(use-package cider :defer t
  :hook ((cider-repl-mode . smartparens-mode)
         (cider-repl-mode . smartparens-strict-mode)))

(provide 'init-prog-clojure)
;;; init-prog-clojure.el ends here
