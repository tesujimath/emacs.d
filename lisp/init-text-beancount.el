;;; init-text-beancount --- setup beancount

;;; Commentary:

;;; Code:

(use-package beancount)

(with-eval-after-load 'apheleia
  (setf (alist-get 'bean-format apheleia-formatters) '("bean-format" "-c" "81" input)))

(provide 'init-text-beancount)
;;; init-text-beancount.el ends here
