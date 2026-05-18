;;; init-prog-nix --- setup nix  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package nix-ts-mode
  :after eglot
  :config
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")))
  :hook (nix-ts-mode . eglot-ensure))

(with-eval-after-load 'apheleia
  (setf (alist-get 'nix-ts-mode apheleia-mode-alist) 'nixpkgs-fmt)
  (setf (alist-get 'nixpkgs-fmt apheleia-formatters) '("nixpkgs-fmt")))

(provide 'init-prog-nix)
;;; init-prog-nix.el ends here
