;;; init-magit --- setup Magit  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package magit
  :bind ("C-x g" . magit-status)
  :custom
  (magit-diff-refine-hunk 'all)
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(provide 'init-magit)
;;; init-magit.el ends here
