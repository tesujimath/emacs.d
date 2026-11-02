;; Elpaca early-init.el -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

;; Create the first frame without these, rather than building them and then
;; taking them away again once init runs.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Font and mode-line changes during init shouldn't each resize the frame.
(setq frame-inhibit-implied-resize t)

;; Startup allocates heavily and then largely stops, so trade memory for fewer
;; collections while it runs, and restore a sane steady state afterwards.
;; `add-hook' creates the hook variable before elpaca's own `defcustom', which
;; leaves an already-set value alone.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'elpaca-after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; runemacs launched from a shortcut doesn't get the environment an MSYS2
;; shell would set up, so recreate the important parts.  This has to happen
;; here rather than in init-env, since the elpaca bootstrap needs git.  The
;; MSYS2 root and environment (clangarm64, ucrt64, ...) come from where this
;; Emacs lives, e.g. c:/msys64/clangarm64/bin/, so they match the build's
;; architecture.
(when (eq system-type 'windows-nt)
  (let* ((env-dir (file-name-directory (directory-file-name invocation-directory)))
         (msystem (file-name-nondirectory (directory-file-name env-dir)))
         (root (file-name-directory (directory-file-name env-dir))))
    (when (member msystem '("clangarm64" "clang64" "clang32" "ucrt64" "mingw64" "mingw32"))
      (let ((msys-dirs (seq-filter #'file-directory-p
                                   (list (expand-file-name "bin" env-dir)
                                         (expand-file-name "usr/bin" root)))))
        (setq exec-path (append msys-dirs exec-path))
        (setenv "PATH" (string-join
                        (append (mapcar (lambda (d) (subst-char-in-string ?/ ?\\ d))
                                        msys-dirs)
                                (list (getenv "PATH")))
                        path-separator))
        (setenv "MSYSTEM" (upcase msystem))))))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
