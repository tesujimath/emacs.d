;;; init-spacehammer --- setup Spacehammer  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package spacehammer
  :if (eq system-type 'darwin)
  :ensure (:host github
                 :repo "agzam/spacehammer"
                 :files ("*.el")))

(provide 'init-spacehammer)
;;; init-spacehammer.el ends here
