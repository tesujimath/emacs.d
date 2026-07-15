;;; init-prog-csharp --- setup csharp  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package csharp-ts-mode
  :ensure nil
  :hook (csharp-ts-mode . eglot-ensure))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(csharp-ts-mode . ("Microsoft.CodeAnalysis.LanguageServer" "--stdio" "--autoLoadProjects"))))

(provide 'init-prog-csharp)
;;; init-prog-csharp.el ends here
