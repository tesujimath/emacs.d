;;; init-prog-csharp --- setup csharp  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package csharp-ts-mode
  :ensure nil
  :hook (csharp-ts-mode . eglot-ensure))

;; Roslyn asks the client to watch every directory in the solution, and eglot
;; spends one kqueue fd per directory, which a large repo exhausts.  Withholding
;; dynamic registration makes Roslyn fall back to its own watcher, which uses
;; FSEvents in the server process and costs Emacs nothing.
(with-eval-after-load 'eglot
  (defclass init-csharp-roslyn-server (eglot-lsp-server) ()
    :documentation "Roslyn, left to watch its own files.")

  (cl-defmethod eglot-client-capabilities ((_server init-csharp-roslyn-server))
    (let ((caps (copy-tree (cl-call-next-method))))
      (plist-put (plist-get caps :workspace)
                 :didChangeWatchedFiles '(:dynamicRegistration :json-false))
      caps))

  (add-to-list 'eglot-server-programs
               '(csharp-ts-mode . (init-csharp-roslyn-server
                                   "Microsoft.CodeAnalysis.LanguageServer" "--stdio" "--autoLoadProjects"))))

(provide 'init-prog-csharp)
;;; init-prog-csharp.el ends here
