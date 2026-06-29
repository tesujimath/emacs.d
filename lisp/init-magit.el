;;; init-magit --- setup Magit  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package magit
  :bind
  ("C-x g" . magit-status)
  ("C-c g l" . magit-list-repositories)
  :custom
  (magit-diff-refine-hunk 'all)
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-repository-directories
   '(("~/home.nix" . 0)
     ("~/.emacs.d" . 0)
     ("~/mobile/notes" . 0)
     ("~/vc/sysconfig/nixos" . 0)
     ("~/vc/sysconfig/nix-darwin" . 0)
     ("~/vc/tesujimath" . 1)))
  (magit-repolist-columns
   '(("Name" 25 magit-repolist-column-ident nil)
     ("Version" 25 magit-repolist-column-version
      ((:sort magit-repolist-version<)))
     ("F"        3 magit-repolist-column-flags nil)
     ("B<U" 3 magit-repolist-column-unpulled-from-upstream
      ((:right-align t) (:sort <)))
     ("B>U" 3 magit-repolist-column-unpushed-to-upstream
      ((:right-align t) (:sort <)))
     ("Path" 99 magit-repolist-column-path nil))))

(use-package git-timemachine)

(provide 'init-magit)
;;; init-magit.el ends here
