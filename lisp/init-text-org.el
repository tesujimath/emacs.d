;;; init-text-org --- setup Org mode  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defun tesujimath/outline-hide-sublevels-1 () "Hide all but L1 headings." (interactive) (outline-hide-sublevels 1))
(defun tesujimath/outline-hide-sublevels-2 () "Hide all but L1-2 headings." (interactive) (outline-hide-sublevels 2))
(defun tesujimath/outline-hide-sublevels-3 () "Hide all but L1-3 headings." (interactive) (outline-hide-sublevels 3))

(defvar tesujimath/org-directory
  (or (seq-find #'file-directory-p '("~/share/notes" "~/mobile/notes"))
      "~/share/notes")
  "Notes directory, which differs between hosts.
Override in `custom-file' for a host that uses neither default.")

(use-package org
  :ensure nil  ; use built-in, or pin to org ELPA below
  :hook (org-mode . visual-line-mode)
  :custom
  (org-directory tesujimath/org-directory)
  ;; A directory entry is expanded on demand, so new files need no restart.
  (org-agenda-files (list tesujimath/org-directory))

  (org-default-notes-file (concat org-directory "/inbox.org"))
  (org-log-done 'time)
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
     ("j" "Journal" entry (file+headline "" "Journal")
      "* %?\12Entered on %U\12  %i\12  %a")))

  :config
  ;; emphasis for / messes up path names
  (setopt org-emphasis-alist (assoc-delete-all "/" org-emphasis-alist))
  (require 'org-tempo)

  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link)
	 :map org-mode-map
         ("C-c 1" . tesujimath/outline-hide-sublevels-1)
         ("C-c 2" . tesujimath/outline-hide-sublevels-2)
         ("C-c 3" . tesujimath/outline-hide-sublevels-3)))

;; Prettier org - may be an acquired taste
;; (use-package org-modern :hook (org-mode . org-modern-mode))

(provide 'init-text-org)
;;; init-text-org.el ends here
