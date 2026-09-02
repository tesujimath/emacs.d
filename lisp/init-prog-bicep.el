;;; init-prog-bicep --- setup bicep IaC for Azure  -*- lexical-binding: t -*-

;;; Commentary:

;; The tree-sitter grammar revision is pinned to match bicep-ts-mode's
;; font-lock rules, which expect that specific version of the grammar.

;;; Code:

(defconst tesujimath/bicep-grammar-url
  "https://github.com/tree-sitter-grammars/tree-sitter-bicep")
(defconst tesujimath/bicep-grammar-revision "v1.1.0")

(use-package bicep-ts-mode
  :ensure (:host github :repo "josteink/bicep-ts-mode")
  ;; bicep-ts-mode's own auto-mode-alist autoload is guarded on the grammar
  ;; already being present, so register the extensions unconditionally here.
  :mode ("\\.bicep\\(param\\)?\\'" . bicep-ts-mode)
  :hook (bicep-ts-mode . eglot-ensure)
  :init
  (with-eval-after-load 'treesit
    (add-to-list 'treesit-language-source-alist
                 `(bicep ,tesujimath/bicep-grammar-url
                         ,tesujimath/bicep-grammar-revision)))
  (with-eval-after-load 'treesit-auto
    (add-to-list 'treesit-auto-recipe-list
                 (make-treesit-auto-recipe
                  :lang 'bicep
                  :ts-mode 'bicep-ts-mode
                  :url tesujimath/bicep-grammar-url
                  :revision tesujimath/bicep-grammar-revision
                  :ext "\\.bicep\\(param\\)?\\'"))
    ;; treesit-auto-langs is snapshotted from the recipe list at load time,
    ;; so a late-added recipe has to be opted in explicitly.
    (add-to-list 'treesit-auto-langs 'bicep)))

;; Bicep.LangServer comes from the nixpkgs bicep-lsp package, and is a
;; wrapper script bundling its own dotnet runtime.
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(bicep-ts-mode . ("Bicep.LangServer"))))

(provide 'init-prog-bicep)
;;; init-prog-bicep.el ends here
