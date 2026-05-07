;;; init-text-beancount --- setup beancount

;;; Commentary:

;;; Code:

(use-package beancount
  :after apheleia
  :config
  (setf (alist-get 'bean-format apheleia-formatters) '("bean-format" "-c" "81" input)))

(provide 'init-text-beancount)
;;; init-text-beancount.el ends here
