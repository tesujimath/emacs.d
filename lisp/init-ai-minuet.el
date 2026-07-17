;;; init-ai-minuet --- setup minuet  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package minuet
  :bind
  (("M-i" . #'minuet-show-suggestion)
   ;;("M-y" . #'minuet-complete-with-minibuffer) ;; use minibuffer for completion
   ;; use overlay for completion
   ;;("C-c m" . #'minuet-configure-provider)
   :map minuet-active-mode-map
   ;; These keymaps activate only when a minuet suggestion is displayed in the current buffer
   ("M-p" . #'minuet-previous-suggestion) ;; invoke completion or cycle to next completion
   ("M-n" . #'minuet-next-suggestion) ;; invoke completion or cycle to previous completion
   ("M-A" . #'minuet-accept-suggestion) ;; accept whole completion
   ;; Accept the first line of completion, or N lines with a numeric-prefix:
   ;; e.g. C-u 2 M-a will accepts 2 lines of completion.
   ("M-a" . #'minuet-accept-suggestion-line)
   ("M-e" . #'minuet-dismiss-suggestion))
  :config
  ;; based on https://github.com/milanglacier/minuet-ai.el#openai-fim-compatible
  (setq minuet-provider 'openai-fim-compatible)
  (setq minuet-n-completions 1) ; recommended for Local LLM for resource saving
  ;; I recommend beginning with a small context window size and incrementally
  ;; expanding it, depending on your local computing power. A context window
  ;; of 512, serves as an good starting point to estimate your computing
  ;; power. Once you have a reliable estimate of your local computing power,
  ;; you should adjust the context window to a larger value.
  (setq minuet-context-window 512)

  ;; ;; Ollama:
  ;; (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:11434/v1/completions")
  ;; ;; an arbitrary non-null environment variable as placeholder.
  ;; (plist-put minuet-openai-fim-compatible-options :api-key "TERM")
  ;; (plist-put minuet-openai-fim-compatible-options :model
  ;;            ;; haven't decided which of these I prefer!
  ;;            ;;"codestral:22b"
  ;;            ;;"deepseek-coder-v2:16b"
  ;;            "qwen2.5-coder:14b" ;; was what I used with Ollama, for minuet and gptel both
  ;;            ;; qwen3-coder FIM awaiting https://github.com/ollama/ollama/issues/12387
  ;;            ;;"qwen3-coder:30b"
  ;;            )

  ;; oMLX:
  (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:8000/v1/completions")
  ;; an arbitrary non-null environment variable as placeholder.
  (plist-put minuet-openai-fim-compatible-options :api-key (lambda () (gptel-api-key-from-auth-source "omlx" "apikey")))
  (plist-put minuet-openai-fim-compatible-options :model "Ornith-1.0-9B-4bit")

  (minuet-set-optional-options minuet-openai-fim-compatible-options :max_tokens 256)
  (minuet-set-optional-options minuet-openai-fim-compatible-options :top_p 0.9))

(provide 'init-ai-minuet)
;;; init-ai-minuet.el ends here
