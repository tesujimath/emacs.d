;;; init-prog-typescript --- setup TypeScript  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package typescript-ts-mode
  :ensure nil
  :config
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode :language-id "typescript") .
                 ;; multiplexed LSP:
                 ("rass" "tsbiome")
                 ;; separate LSPs for testing:
                 ;; ("typescript-language-server" "--stdio")
                 ;; ("biome" "lsp-proxy")
                 ))
  :hook ((typescript-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'biome apheleia-formatters) '("biome" "format" "--stdin-file-path" filepath)))

(provide 'init-prog-typescript)
;;; init-prog-typescript.el ends here
