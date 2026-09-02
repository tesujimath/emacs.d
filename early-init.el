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

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
