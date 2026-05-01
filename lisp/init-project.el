;;; init-project --- setup project

;;; Commentary:

;;; Code:

(use-package project
  :ensure nil)  ; built-in, but consult integrates with it

;; Optional: projectile for richer features
;; (use-package projectile
;;   :init (projectile-mode)
;;   :bind-keymap ("C-c p" . projectile-command-map))

(provide 'init-project)
;;; init-project.el ends here
