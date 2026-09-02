;;; init-text-beancount --- setup beancount  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; beancount's autoloads already register `.beancount' in `auto-mode-alist'.
(use-package beancount
  :defer t
  :custom (beancount-number-alignment-column 79))

(with-eval-after-load 'apheleia
  (setf (alist-get 'bean-format apheleia-formatters) '("bean-format" "-c" "81" input)))

(provide 'init-text-beancount)
;;; init-text-beancount.el ends here
