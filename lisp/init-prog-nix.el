;;; init-prog-nix --- setup nix

;;; Commentary:

;;; Code:

(use-package nix-ts-mode
  :after apheleia eglot
  :config
  (setf (alist-get 'nix-ts-mode apheleia-mode-alist) 'nixpkgs-fmt
        (alist-get 'nixpkgs-fmt apheleia-formatters) '("nixpkgs-fmt"))
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")))
  :hook (nix-ts-mode . eglot-ensure))

(provide 'init-prog-nix)
;;; init-prog-nix.el ends here
