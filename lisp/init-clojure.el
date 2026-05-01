;;; init-clojure --- setup Clojure

;;; Commentary:

;;; Code:

;; TODO CIDER

;; Structured editing
(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config (require 'smartparens-config))



(provide 'init-clojure)
;;; init-clojure.el ends here
