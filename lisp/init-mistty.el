;;; init-mistty --- setup mistty  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package mistty
  :bind (("C-c S" . mistty)

         ;; bind here the shortcuts you'd like the
         ;; shell to handle instead of Emacs.
         :map mistty-prompt-map

         ;; fish: directory history
         ("M-<up>" . mistty-send-key)
         ("M-<down>" . mistty-send-key)
         ("M-<left>" . mistty-send-key)
         ("M-<right>" . mistty-send-key)))

(provide 'init-mistty)
;;; init-mistty.el ends here
