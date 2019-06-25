;;; init-preload-local.el --- initalize the annex to the configuration
;;; Commentary:

;; This file arranges to load init-local from a separate annex.

;;; Code:

(let ((annex-dir (expand-file-name "~/.emacs.d.annex")))
  (if (file-directory-p annex-dir)
      (push annex-dir load-path)))

(provide 'init-preload-local)

;;; init-preload-local.el ends here
