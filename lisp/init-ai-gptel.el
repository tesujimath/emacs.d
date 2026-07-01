;;; init-ai-gptel --- setup gptel  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package gptel
  :config
  (setq gptel-model 'qwen2.5-coder:14b ;; same model I'm using in minuet
        gptel-backend (gptel-make-ollama "Ollama"
                        :host "localhost:11434"
                        :stream t
                        :models '(codestral:22b
                                  deepseek-coder-v2:16b
                                  deepseek-coder:6.7b-instruct-q6_K
                                  devstral-small-2:24b
                                  llama3:8b-instruct-q6_K
                                  mixtral:8x7b-instruct-v0.1-q5_K_M
                                  phi3:14b-medium-128k-instruct-q6_K
                                  qwen2.5-coder:14b
                                  qwen3-coder:30b
                                  qwen3.6:27b
                                  qwen3.6:35b-a3b-coding-nvfp4))))

(provide 'init-ai-gptel)
;;; init-ai-gptel.el ends here
