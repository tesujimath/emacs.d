;;; init-prog-python --- setup python  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package python-ts-mode
  :ensure nil
  :hook ((python-ts-mode . eglot-ensure)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff)
  (setf (alist-get 'ruff apheleia-formatters) '("ruff" "format" "-")))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("rass" "pyright-ruff"))))

;; Eglot's workspace root comes from `project.el', which for a .py file inside
;; a large third-party monorepo (a nixpkgs checkout, say) is the whole
;; repository.  Pyright then asks us to watch it, and eglot adds one kqueue
;; watch — i.e. one file descriptor — per directory, so a 37k-directory root
;; exhausts what Emacs can hold.  Anchor Python workspaces on packaging
;; metadata instead.

(defconst init-python-project-markers
  '("pyproject.toml" "setup.py" "setup.cfg" "requirements.txt" "Pipfile")
  "Files that mark the root of a Python project.")

(defun init-python--marked-p (dir)
  "Non-nil if DIR holds one of `init-python-project-markers'."
  (seq-some (lambda (marker) (file-exists-p (expand-file-name marker dir)))
            init-python-project-markers))

(defun init-python--workspace-root (dir)
  "Nearest ancestor of DIR that looks like a Python project root.
The search stops at the enclosing repository so it cannot wander up into
the home directory.  Returns nil when no marker is found."
  (let ((found (locate-dominating-file
                dir
                (lambda (d)
                  (or (init-python--marked-p d)
                      (file-exists-p (expand-file-name ".git" d)))))))
    (and found (init-python--marked-p found) found)))

(defun init-python--project-at (root)
  "Return a project object rooted at ROOT, VC-backed where possible.
Narrowing the root is not enough on its own: a `transient\=' project lists
its files by running `find -L\=', which follows symlinks and knows nothing
about .gitignore.  In a direnv-using repo that walks
.direnv/flake-inputs/*-source straight into the nixpkgs closure in the Nix
store — 38k directories — plus .venv on the way past, which is how we ran
out of file descriptors a second time.  `git ls-files\=' reports 33
directories for the same repo.  A vc project keeps ROOT as the root but
delegates the listing to the backend, so both stay true."
  (let ((backend (vc-responsible-backend (directory-file-name root) t)))
    (if backend
        (progn
          (require (intern (concat "vc-" (downcase (symbol-name backend)))) nil t)
          (list 'vc backend root))
      (cons 'transient root))))

(defun init-python-eglot-project (dir)
  "Return the Python project eglot should use for DIR.
Only consulted in `eglot-lsp-context', so ordinary `project.el' commands
still see the VC root.  Falls back to DIR itself when there is no
packaging metadata, which keeps a stray file in a monorepo from handing
the entire repository to the language server."
  (when (and eglot-lsp-context
             (derived-mode-p 'python-base-mode))
    (init-python--project-at
     (file-name-as-directory
      (expand-file-name (or (init-python--workspace-root dir) dir))))))

(with-eval-after-load 'eglot
  (add-hook 'project-find-functions #'init-python-eglot-project))

(provide 'init-prog-python)
;;; init-prog-python.el ends here
