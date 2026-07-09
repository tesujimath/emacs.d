;;; init-prog-typescript --- setup TypeScript  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package typescript-ts-mode
  :ensure nil
  :hook ((typescript-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'biome apheleia-formatters) '("biome" "format" "--stdin-file-path" filepath)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode :language-id "typescript") .
                 ;; multiplexed LSP:
                 ("rass" "tsbiome")
                 ;;(eglot-deno-biome "rass" "deno-biome")
                 ;; separate LSPs for testing:
                 ;;(eglot-deno "deno" "lsp" "-L" "info")
                 ;; ("biome" "lsp-proxy")
                 ))

  (defclass eglot-deno-biome (eglot-lsp-server) ()
    :documentation "A custom class for deno/biome LSP.")

  (cl-defmethod eglot-initialization-options ((server eglot-deno-biome))
    "Pass through required deno initialization options for SERVER."
    ;; see https://github.com/joaotavora/rassumfrassum#configuring-individual-servers
    ;; for option multiplexing
    '(:rass
      (:deno
       (:enable t
                :unstable t
	        :typescript
	        (:inlayHints
	         (:variableTypes
                  (:enabled t)
	          :parameterTypes
                  (:enabled t)))))))

  (defclass eglot-deno (eglot-lsp-server) ()
    :documentation "A custom class for deno lsp.")

  (cl-defmethod eglot-initialization-options ((server eglot-deno))
    "Passes through required deno initialization options"
    '(:enable t
              :unstable t
	      :typescript
	      (:inlayHints
	       (:variableTypes
                (:enabled t)
	        :parameterTypes
                (:enabled t))))))

(provide 'init-prog-typescript)
;;; init-prog-typescript.el ends here
