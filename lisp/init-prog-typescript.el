;;; init-prog-typescript --- setup TypeScript  -*- lexical-binding: t -*-

;;; Commentary:
;;;
;;; We define a deno-mode, derived from typescript-ts-mode, purely for standalone deno scripts,
;;; because the TypeScript LSP doesn't understand deno-style inline package dependencies.
;;; Also, at the time of writing, the deno LSP is not as robust as the TypeScript one, so we
;;; don't want to use it more widely.  This may change in time.

;;; Code:

(use-package typescript-ts-mode
  :ensure nil
  :hook ((typescript-ts-mode . eglot-ensure)))

(use-package add-node-modules-path
  :hook ((typescript-ts-mode . add-node-modules-path)))

(define-derived-mode deno-mode typescript-ts-mode "Deno"
  "Major mode for standalone Deno scripts, derived from `typescript-ts-mode'.")

(add-to-list 'interpreter-mode-alist '("deno" . deno-mode))

(with-eval-after-load 'apheleia
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'deno-mode apheleia-mode-alist) 'biome)
  (setf (alist-get 'biome apheleia-formatters) '("biome" "format" "--stdin-file-path" filepath "--indent-style=space")))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode :language-id "typescript") .
                 ;; multiplexed LSP:
                 ("rass" "tsbiome")
                 ;; separate LSPs for testing:
                 ;; ("typescript-language-server" "--stdio")
                 ;; ("biome" "lsp-proxy")
                 ))
  (add-to-list 'eglot-server-programs
               '((deno-mode :language-id "typescript") .
                 ;; multiplexed LSP:
                 ;;("rass" "deno-biome")
                 ;; separate LSPs for testing:
                 ;; Alas the deno LSP simply doesn't work, even in 2.9.2 😭
                 ;; ("deno" "lsp" "-L" "info")
                 ("biome" "lsp-proxy")
                 ))

  (let ((typescript-workspace-configuration
         '(:inlayHints
           (:includeInlayParameterNameHints "all"
                                            :includeInlayParameterNameHintsWhenArgumentMatchesName t
                                            :includeInlayFunctionParameterTypeHints t
                                            :includeInlayVariableTypeHints t
                                            :includeInlayPropertyDeclarationTypeHints t
                                            :includeInlayFunctionLikeReturnTypeHints t
                                            :includeInlayEnumMemberValueHints t)))

        ;; placeholder, not yet used, may not be quite right
        (deno-workspace-configuration
         '(:enable t
                   :unstable t
	           :typescript
	           (:inlayHints
	            (:variableTypes
                     (:enabled t)
	             :parameterTypes
                     (:enabled t))))))

    ;; Set typescript workspace configuration both with and without rass.
    ;; See https://github.com/joaotavora/rassumfrassum#configuring-individual-servers
    ;; for option multiplexing.
    (setq-default eglot-workspace-configuration
                  (-> (default-value 'eglot-workspace-configuration)
                      (plist-put :typescript typescript-workspace-configuration)
                      (plist-put :rass `(:typescript-language-server (:typescript ,typescript-workspace-configuration)))))))

(provide 'init-prog-typescript)
;;; init-prog-typescript.el ends here
