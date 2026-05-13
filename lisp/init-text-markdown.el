;;; init-text-markdown --- setup markdown support  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package markdown-mode
  :hook (markdown-mode . visual-line-mode))

(provide 'init-text-markdown)
;;; init-text-markdown.el ends here
