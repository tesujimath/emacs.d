;;; init-beancount --- setup beancount

;;; Commentary:

;;; Code:

(use-package beancount
  :after apheleia
  :config
  (setf (alist-get 'bean-format apheleia-formatters) '("bean-format" "-c" "81" input)))

(provide 'init-beancount)
;;; init-beancount.el ends here
