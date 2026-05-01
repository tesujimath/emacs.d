;;; init-org --- setup Org

;;; Commentary:

;;; Code:

(use-package org
  :ensure nil  ; use built-in, or pin to org ELPA below
  :custom
  (org-directory "~/org")
  (org-default-notes-file (concat org-directory "/inbox.org"))
  (org-agenda-files (list org-directory))
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@)" "|" "DONE(d)" "CANCELLED(c@)")))
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link)))

;; Prettier org
(use-package org-modern
  :hook (org-mode . org-modern-mode))

;; Capture templates - TODO
(setq org-capture-templates
      '(("t" "Todo"  entry (file+headline "~/org/inbox.org" "Tasks")    "* TODO %?\n  %i\n  %a")
        ("n" "Note"  entry (file+headline "~/org/notes.org" "Notes")    "* %? :note:\n  %U\n  %i")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")        "* %U %?\n  %i")))

(provide 'init-org)
;;; init-org.el ends here
