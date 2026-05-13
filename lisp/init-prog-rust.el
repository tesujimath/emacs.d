;;; init-prog-rust --- setup rust  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defun tesujimath/eglot-disable-rust-flymake ()
  "Disable rust-ts-flymake in favour of eglot."
  (setq-local flymake-diagnostic-functions
              (remove 'rust-ts-flymake flymake-diagnostic-functions)))

(use-package rust-ts-mode
  :ensure nil
  :hook ((rust-ts-mode . eglot-ensure)
         (rust-ts-mode . tesujimath/eglot-disable-rust-flymake)))

(provide 'init-prog-rust)
;;; init-prog-rust.el ends here
