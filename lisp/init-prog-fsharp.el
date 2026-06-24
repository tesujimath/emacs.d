;;; init-prog-fsharp --- setup fsharp  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fsharp-ts-mode
  :ensure (:host github :repo "bbatsov/fsharp-ts-mode")
  :config
  (add-to-list 'eglot-server-programs '(fsharp-ts-mode . ("fsautocomplete")))
  :hook ((fsharp-ts-mode . eglot-ensure)
         (fsharp-ts-mode . fsharp-ts-repl-minor-mode)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'fsharp-ts-mode apheleia-mode-alist) 'fantomas)
  ;; F# autoformat using fantomas
  (setf (alist-get 'fantomas apheleia-formatters) '("fantomas" input "--out" output)))

(provide 'init-prog-fsharp)
;;; init-prog-fsharp.el ends here
