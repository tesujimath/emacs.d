;;; init-multiple-cursors --- setup multiple-cursors

;;; Commentary:

;;; Code:

(use-package multiple-cursors
  :bind (("C->"     . mc/mark-next-like-this)
         ("C-<"     . mc/mark-previous-like-this)
         ("C-c ."   . mc/mark-all-like-this)
         ("C-c C-." . mc/edit-lines)))

(provide 'init-multiple-cursors)
;;; init-multiple-cursors.el ends here
