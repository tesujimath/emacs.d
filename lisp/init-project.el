;;; init-project --- setup project

;;; Commentary:

;;; Code:

(use-package project
  :ensure nil
  :bind-keymap ("C-c p" . project-prefix-map)
  :custom
  (project-switch-commands
   '((project-find-file "Find file" ?f)
     (project-find-regexp "Find regexp" ?g)
     (project-dired "Dired" ?d)
     ;; (project-eshell "Eshell" ?e)
     (magit-project-status "Magit" ?m))))

(provide 'init-project)
;;; init-project.el ends here
