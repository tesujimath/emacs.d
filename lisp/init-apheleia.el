;;; init-apheleia.el --- autoformat  -*- lexical-binding: t -*-
;;; Commentary:
;;;  Auto-format with apheleia, but only in files which were already
;;;  correctly formatted when visited, so we don't reformat other
;;;  people's code just by touching it.
;;;
;;; Code:

(defun my/apheleia-mode-if-already-formatted ()
  "Enable `apheleia-mode' if the visited file is already formatted.
New files are always formatted."
  (require 'apheleia)
  (unless (or apheleia-inhibit
              (run-hook-with-args-until-success 'apheleia-inhibit-functions)
              (apheleia--disallowed-p))
    (when-let* ((formatters (apheleia--get-formatters)))
      (if (not (file-exists-p buffer-file-name))
          (apheleia-mode +1)
        (let ((buffer (current-buffer))
              (hash (apheleia--buffer-hash)))
          (apheleia--run-formatters
           formatters buffer (file-remote-p buffer-file-name)
           (lambda (err formatted)
             (when (and (not err) (buffer-live-p buffer))
               (with-current-buffer buffer
                 ;; If edited while the formatter ran we can't tell.
                 (when (and (equal hash (apheleia--buffer-hash))
                            (let ((case-fold-search nil))
                              (zerop (compare-buffer-substrings
                                      buffer nil nil formatted nil nil))))
                   (apheleia-mode +1)))))))))))

(use-package apheleia
  :hook (find-file . my/apheleia-mode-if-already-formatted))

(provide 'init-apheleia)
;;; init-apheleia.el ends here
