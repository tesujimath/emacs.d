;;; init-prog-nix --- setup nix

;;; Commentary:

;;; Code:

(use-package nix-ts-mode
  :after eglot
  :config
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")))
  :hook (nix-ts-mode . eglot-ensure))

(with-eval-after-load 'apheleia
  (dolist (mode '(nix-mode nix-ts-mode))
    (setf (alist-get mode apheleia-mode-alist) 'nixpkgs-fmt))
  (setf (alist-get 'nixpkgs-fmt apheleia-formatters) '("nixpkgs-fmt")))

(provide 'init-prog-nix)
;;; init-prog-nix.el ends here
