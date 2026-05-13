;;; init-prog-bash --- setup bash  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package bash-ts-mode
  :ensure nil
  :config
  (add-to-list 'eglot-server-programs '(bash-ts-mode . ("bash-language-server")))
  :hook ((bash-ts-mode . eglot-ensure)))

(provide 'init-prog-bash)
;;; init-prog-bash.el ends here
