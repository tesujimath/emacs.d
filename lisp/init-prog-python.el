;;; init-prog-python --- setup python  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package python-ts-mode
  :ensure nil
  :hook ((python-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff)
  (setf (alist-get 'ruff apheleia-formatters) '("ruff" "format" "-")))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright-langserver" "--stdio"))))

(provide 'init-prog-python)
;;; init-prog-python.el ends here
