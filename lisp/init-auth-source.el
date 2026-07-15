;;; init-auth-source --- setup auth-source  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package auth-source
  :ensure nil
  :config
  (when (string= system-type "darwin")
    (add-to-list 'auth-sources 'macos-keychain-internet)))

(provide 'init-auth-source)
;;; init-auth-source.el ends here
