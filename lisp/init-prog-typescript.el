;;; init-prog-typescript --- setup TypeScript  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eglot-typescript-preset
  :ensure (:host github
                 :repo "mwolson/eglot-typescript-preset")
  :custom
  (eglot-typescript-preset-lsp-server 'rass)
  (eglot-typescript-preset-rass-tools
   '(typescript-language-server biome)))

(use-package typescript-ts-mode
  :ensure nil
  :hook ((typescript-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'biome apheleia-formatters) '("biome" "format" "--stdin-file-path" filepath)))

(provide 'init-prog-typescript)
;;; init-prog-typescript.el ends here
