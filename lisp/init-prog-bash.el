;;; init-prog-bash --- setup bash  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package bash-ts-mode
  :ensure nil
  :hook ((bash-ts-mode . eglot-ensure)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(bash-ts-mode . ("bash-language-server" "start"))))

(provide 'init-prog-bash)
;;; init-prog-bash.el ends here
