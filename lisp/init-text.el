;;; init-text --- setup text related modes  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(add-hook 'text-mode-hook #'visual-line-mode)

(use-package jinx
  :ensure nil ; loaded via Nix Home Manager
  ;; don't use jinx-mode until jinx is picking up an enchant without nuspell,
  ;; since that crashes on my Datacom Mac if permissions problems anywhere
  ;;:hook ((text-mode . jinx-mode)
  ;;       (markdown-mode . jinx-mode)
  ;;       (org-mode  . jinx-mode))
  :bind (("M-$"   . jinx-correct)
         ("C-M-$" . jinx-languages)
         :map jinx-mode-map
         ;; M-n/M-p are flymake's, and jinx-mode is active in prog buffers too
         ("M-s n" . jinx-next)
         ("M-s p" . jinx-previous))
  :custom
  (jinx-languages "en_GB"))

;; text-oriented modes
(require 'init-text-beancount)
(require 'init-text-csv)
(require 'init-text-json)
(require 'init-text-markdown)
(require 'init-text-org)

(provide 'init-text)
;;; init-text.el ends here
