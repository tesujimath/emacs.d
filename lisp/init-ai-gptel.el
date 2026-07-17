;;; init-ai-gptel --- setup gptel  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package gptel
  :config
  (defvar my/gptel-ollama (gptel-make-ollama "Ollama"
                            :host "localhost:11434"
                            :stream t
                            :models '(codestral:22b
                                      deepseek-coder-v2:16b
                                      deepseek-coder:6.7b-instruct-q6_K
                                      devstral-small-2:24b
                                      llama3:8b-instruct-q6_K
                                      mixtral:8x7b-instruct-v0.1-q5_K_M
                                      phi3:14b-medium-128k-instruct-q6_K
                                      qwen2.5-coder:14b ;; same model I've been using in minuet
                                      qwen3-coder:30b
                                      qwen3.6:27b
                                      qwen3.6:35b-a3b-coding-nvfp4)))
  (defvar my/gptel-omlx
    (gptel-make-openai "oMLX"
      :host "localhost:8000"
      :protocol "http"
      :key (lambda () (gptel-api-key-from-auth-source "omlx" "apikey"))
      :stream t
      :models '(Devstral-Small-2-24B-Instruct-2512-4bit
                Ornith-1.0-35B-5bit-XL-mlx
                Ornith-1.0-9B-4bit
                Qwen3.6-27B-MLX-4bit)))

  (setq gptel-model 'Ornith-1.0-9B-4bit
        gptel-backend my/gptel-omlx))

(provide 'init-ai-gptel)
;;; init-ai-gptel.el ends here
