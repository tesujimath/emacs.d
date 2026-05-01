;;; init-org --- setup Org mode

;;; Commentary:

;;; Code:

"Hide all outline sublevels down to N."
(defun tesujimath/outline-hide-sublevels-1 () (interactive) (outline-hide-sublevels 1))
(defun tesujimath/outline-hide-sublevels-2 () (interactive) (outline-hide-sublevels 2))
(defun tesujimath/outline-hide-sublevels-3 () (interactive) (outline-hide-sublevels 3))

(use-package org
  :ensure nil  ; use built-in, or pin to org ELPA below
  :custom
  (org-directory "~/mobile/notes")
  (org-agenda-files (file-expand-wildcards (concat org-directory "/*.org")))

  (org-default-notes-file (concat org-directory "/inbox.org"))(org-log-done 'time)
  (org-hide-emphasis-markers t)
  (org-log-into-drawer t)
  (org-outline-path-complete-in-steps nil)
  (org-refile-targets '((nil :maxlevel . 2) (org-agenda-files :maxlevel . 2)))
  (org-refile-use-outline-path 'file)

  (org-todo-keywords
   '((sequence "BACKLOG(b!)" "TODO(t)" "IN-PROGRESS(i!)" "|" "DONE(d!/!)"
               "CANCELLED(c@)")
     (sequence "IN-PROGRESS(i!)" "WAITING(w@/!)" "|" "DONE(d!/!)"
               "CANCELLED(c@/!)")
     (sequence "WAITING(w@/!)" "IN-PROGRESS(i!)" "|" "CANCELLED(c@/!)")))

  (org-capture-templates
   '(("L" "Link" entry (file+headline "resources.org" "Unclassified")
      "** TODO %:description\12%:link\12%?")
     ("p" "Link" entry (file+headline "resources.org" "Unclassified")
      "** TODO %:description\12%:link\12\12%i\12%?")
     ("t" "Todo" entry (file+headline "" "Tasks")
      "* TODO %?\12  %i\12  %a")
     ("!" "Ideas" entry (file+headline "" "Ideas")
      "* %?\12Entered on %U\12  %i\12  %a")
     ("j" "Journal" entry (file+headline "Journal")
      "* %?\12Entered on %U\12  %i\12  %a")))

  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link)
	 :map org-mode-map
         ("C-c 1" . tesujimath/outline-hide-sublevels-1)
         ("C-c 2" . tesujimath/outline-hide-sublevels-2)
         ("C-c 3" . tesujimath/outline-hide-sublevels-3)))

;; Prettier org - may be an acquired taste
;; (use-package org-modern :hook (org-mode . org-modern-mode))

(provide 'init-org)
;;; init-org.el ends here
