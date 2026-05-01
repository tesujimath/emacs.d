;; use host-specific customization
(setq custom-file (expand-file-name
                   (format "custom.%s.el" (car (split-string system-name "\\.")))
                   user-emacs-directory))
(load custom-file :no-error)

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
        ;; Enable Elpaca support for use-package's :ensure keyword.
        (elpaca-use-package-mode)
        ;; Assume :ensure t unless otherwise specified
        (setq use-package-always-ensure t))

;; TODO this doesn't seem to have any effect:
(setq elpaca-lock-file (expand-file-name "elpaca.lock" user-emacs-directory))

;; Packages that are built-in but need newer versions from MELPA
(use-package transient :ensure t)
;; Wait for these until trying to install anything that depends on them
(elpaca-wait)

;; setup directory structure and load packages
(defvar user-lisp-dir (expand-file-name "lisp" (file-name-directory load-file-name))
  "user lisp directory.")
(add-to-list 'load-path user-lisp-dir)

;; TODO
;; (require 'init-actions)
(require 'init-clojure)
(require 'init-completion)
(require 'init-envrc)
(require 'init-lisp)
(require 'init-magit)
(require 'init-org)
(require 'init-programming)
;; (require 'init-project)
(require 'init-quality-of-life)
