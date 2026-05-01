;;; init-completion --- setup completion

;;; Commentary:

;;; Code:

;; vertico replaces the default minibuffer completion with a vertical list
(use-package vertico
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-count 15))

;; orderless adds fuzzy/space-separated matching to vertico
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; marginalia adds annotations to vertico candidates
(use-package marginalia
  :init (marginalia-mode))

;; consult replaces specific commands with richer versions
(use-package consult
  :bind (("C-s"   . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-s r" . consult-ripgrep)
         ("M-s f" . consult-find)
	 ("C-c T" . consult-theme))
  :custom
  (consult-preview-key "M-."))

;; corfu is for in-buffer pop-up completion
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  (corfu-quit-no-match 'separator)
  :init (global-corfu-mode))

;; cape extends corfu's completion sources
(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(provide 'init-completion)
;;; init-completion.el ends here
