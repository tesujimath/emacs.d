;;; init-vc --- setup version control  -*- lexical-binding: t -*-

;;; Commentary:
;;
;; We use Magit for version control, and only want vc.el for the branch
;; indicator in the modeline.
;;
;; By default `vc-refresh-state' runs synchronously from `find-file-hook',
;; spawning five git subprocesses before the buffer appears.  On a machine with
;; several Endpoint Security agents that is most of the cost of opening a file
;; (measured: 92ms of a 94ms open).  So we defer it to idle time instead.
;;
;; doom-modeline advises `vc-refresh-state' :after, so its VCS segment still
;; updates itself once our deferred refresh runs.

;;; Code:

(require 'vc-hooks)

;; We only ever use Git, and probing eight backends per file is not free.
(setq vc-handled-backends '(Git))

(defvar tesujimath/vc-refresh-idle-delay 1.0
  "Seconds of idle time before refreshing vc state for the current buffer.")

(defvar-local tesujimath/vc-state-refreshed nil
  "Non-nil once `vc-refresh-state' has run in this buffer.")

(defvar tesujimath/vc-refresh-timer nil
  "Idle timer driving deferred vc state refresh.")

(defun tesujimath/vc-refresh-state-if-stale ()
  "Refresh vc state for the current buffer unless already done.
Cheap no-op in the common case, so it is safe to run on an idle timer."
  (when (and buffer-file-name
             (not tesujimath/vc-state-refreshed))
    ;; Set the flag first: if `vc-refresh-state' errors (e.g. a git binary that
    ;; has gone away under a nix garbage collect) we must not retry every second.
    (setq tesujimath/vc-state-refreshed t)
    (with-demoted-errors "vc refresh: %S"
      (vc-refresh-state))))

(defun tesujimath/vc-invalidate-state ()
  "Mark this buffer's vc state as stale, so it is refreshed when next idle."
  (setq tesujimath/vc-state-refreshed nil))

;; Saving can change the file's vc state, so recompute it after a save.
(add-hook 'after-save-hook #'tesujimath/vc-invalidate-state)

;; The expensive bit: don't block `find-file' on git.
(remove-hook 'find-file-hook #'vc-refresh-state)

(unless tesujimath/vc-refresh-timer
  (setq tesujimath/vc-refresh-timer
        (run-with-idle-timer tesujimath/vc-refresh-idle-delay t
                             #'tesujimath/vc-refresh-state-if-stale)))

(provide 'init-vc)
;;; init-vc.el ends here
