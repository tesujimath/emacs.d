;;; init-prog-fennel --- setup fennel  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; fennel-mode's own autoloads already register `.fnl' in `auto-mode-alist', so
;; doing it from :config only forced the package to load at startup.
(use-package fennel-mode
  :ensure (:host sourcehut
                 :repo "technomancy/fennel-mode"
                 :tag "0.9.2")
  :defer t)

(provide 'init-prog-fennel)
;;; init-prog-fennel.el ends here
