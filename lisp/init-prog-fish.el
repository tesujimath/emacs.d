;;; init-prog-fish --- setup fish  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fish-mode
  :hook ((fish-mode . eglot-ensure)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(fish-mode . ("fish-lsp" "start"))))

(provide 'init-prog-fish)
;;; init-prog-fish.el ends here
