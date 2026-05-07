;;; init-prog-python --- setup python

;;; Commentary:

;;; Code:

(use-package python-ts-mode
  :ensure nil
  :config
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright")))
  :hook ((python-ts-mode . eglot-ensure)))

(provide 'init-prog-python)
;;; init-prog-python.el ends here
