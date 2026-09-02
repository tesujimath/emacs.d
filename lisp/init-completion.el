;;; init-completion --- setup completion  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; savehist persists minibuffer history between sessions, which is what lets
;; vertico and consult float recently used candidates to the top.
(use-package savehist
  :ensure nil
  :init (savehist-mode)
  :custom
  (history-length 300)
  (savehist-additional-variables '(search-ring regexp-search-ring)))

;; vertico replaces the default minibuffer completion with a vertical list
(use-package vertico
  :init
  (vertico-mode)
  ;; embark and consult both invite recursive minibuffers, so make the depth
  ;; visible when you are in one.
  (minibuffer-depth-indicate-mode)
  :custom
  (vertico-cycle t)
  (vertico-count 15)
  (enable-recursive-minibuffers t)
  ;; omit commands that don't apply to the current mode from M-x
  (read-extended-command-predicate #'command-completion-default-include-p))

;; orderless adds fuzzy/space-separated matching to vertico
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  ;; the built-in per-category styles would otherwise override orderless
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; marginalia adds annotations to vertico candidates
(use-package marginalia
  :init (marginalia-mode))

(defun tesujimath/consult-ripgrep-at-point ()
  "Consult ripgrep for symbol at point."
  (interactive)
  (consult-ripgrep nil (thing-at-point 'symbol)))
(use-package consult
  :bind (("C-s"   . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-s r" . tesujimath/consult-ripgrep-at-point)
         ("M-s f" . consult-find)
	 ("C-c T" . consult-theme)
         ("C-c m" . consult-mark)
         ("C-c M" . consult-global-mark)
         ("C-c r s" . consult-imenu))
  :custom
  (consult-preview-key "M-."))

;; corfu is for in-buffer pop-up completion
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.3) ; increased from 0.2 in favour of eglot
  (corfu-auto-prefix 3)  ; increased from 2 in favour of eglot
  (corfu-cycle t)
  (corfu-quit-no-match 'separator)
  ;; TAB indents, and completes once the line is already indented
  (tab-always-indent 'complete)
  :init (global-corfu-mode))

;; cape extends corfu's completion sources
(use-package cape
  ;; C-c p belongs to `project-prefix-map', see init-project.el
  :bind ("C-c P" . cape-prefix-map)
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(provide 'init-completion)
;;; init-completion.el ends here
