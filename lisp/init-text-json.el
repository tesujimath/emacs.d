;;; init-text-json.el --- rich JSON exploration stack  -*- lexical-binding: t; -*-

(use-package jq-mode
  :commands (jq-interactively))

(with-eval-after-load 'json-ts-mode
  (define-key json-ts-mode-map (kbd "C-c C-j") #'jq-interactively))

(add-hook 'json-ts-mode-hook #'treesit-fold-mode)

(with-eval-after-load 'json-ts-mode
  (define-key json-ts-mode-map (kbd "C-c C-t") #'treesit-fold-toggle))
;; Also available, unbound by default: `treesit-fold-close-all' and
;; `treesit-fold-open-all', for folding/unfolding the whole buffer at once.


(provide 'init-text-json)
;;; init-text-json.el ends here
