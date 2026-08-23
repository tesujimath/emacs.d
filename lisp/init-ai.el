;;; init-ai --- setup ai modes  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; ai-related modes, not on Windows
(unless (eq system-type 'windows-nt)
  (require 'init-ai-agent-shell)
  (require 'init-ai-gptel)
  (require 'init-ai-minuet))

(provide 'init-ai)
;;; init-ai.el ends here
