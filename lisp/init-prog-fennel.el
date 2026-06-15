;;; init-prog-fennel --- setup fennel  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fennel-mode
  :ensure (:host sourcehut
                 :repo "technomancy/fennel-mode"
                 :tag "0.9.2")
  :config
  (add-to-list 'auto-mode-alist '("\\.fnl\\'" . fennel-mode)))

(provide 'init-prog-fennel)
;;; init-prog-fennel.el ends here
