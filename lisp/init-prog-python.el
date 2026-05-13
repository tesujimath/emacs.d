;;; init-prog-python --- setup python  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package python-ts-mode
  :ensure nil
  :config
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright")))
  :hook ((python-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (dolist (mode '(python-mode python-ts-mode))
    (setf (alist-get mode apheleia-mode-alist) 'ruff))
  (setf (alist-get 'ruff apheleia-formatters) '("ruff" "format" "-")))

(provide 'init-prog-python)
;;; init-prog-python.el ends here
