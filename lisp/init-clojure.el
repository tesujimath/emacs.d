;;; init-clojure --- setup Clojure

;;; Commentary:

;;; Code:


(use-package clojure-mode)
;;(use-package clojure-ts-mode)
(use-package clj-refactor)
(use-package flycheck-clj-kondo)

(use-package cider :defer t)

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
  (local-set-key (kbd "C-c `") #'tesujimath/lint-clj-project))

(defvar tesujimath/clojure-mode-hook 'tesujimath/clojure-mode-defaults)

(add-hook 'clojure-mode-hook (lambda () (run-hooks 'tesujimath/clojure-mode-hook)))

;; TODO needs init-apheleia
;; Clojure autoformat using zprint
;; zprint -c: read config from project if present
;; (with-eval-after-load 'apheleia  (push '(zprint . ("zprint" "{:fn-map {\"f/attempt-all\" :binding, \"prop/for-all\" :binding}}")) apheleia-formatters)
;;                       (setf (alist-get 'clojure-mode apheleia-mode-alist) 'zprint))

;; (with-eval-after-load 'flycheck
;;   (require 'flycheck-clj-kondo))



(provide 'init-clojure)
;;; init-clojure.el ends here
