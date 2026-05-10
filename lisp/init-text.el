;;; init-text --- setup text related modes

;;; Commentary:

;;; Code:

(add-hook 'text-mode-hook #'visual-line-mode)

(use-package jinx
  :ensure nil ; loaded via Nix Home Manager
  :hook ((text-mode . jinx-mode)
         (markdown-mode . jinx-mode)
         (org-mode  . jinx-mode))
  :bind (("M-$"   . jinx-correct)
         ("C-M-$" . jinx-languages)
         :map jinx-mode-map
         ("M-n" . jinx-next)
         ("M-p" . jinx-previous))
  :custom
  (jinx-languages "en_GB"))

;; text-oriented modes
(require 'init-text-beancount)
(require 'init-text-csv)
(require 'init-text-markdown)
(require 'init-text-org)

(provide 'init-text)
;;; init-text.el ends here
