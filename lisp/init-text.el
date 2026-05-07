;;; init-text --- setup text related modes

;;; Commentary:

;;; Code:

(add-hook 'text-mode-hook #'visual-line-mode)

;; text-oriented modes
(require 'init-text-beancount)
(require 'init-text-csv)
(require 'init-text-markdown)
(require 'init-text-org)

(provide 'init-text)
;;; init-text.el ends here
