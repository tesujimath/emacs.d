;;; init-docker --- setup docker  -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Talks to Colima's daemon via DOCKER_HOST, imported in `init-env'.
(use-package docker
  :bind ("C-c d" . docker))

(provide 'init-docker)
;;; init-docker.el ends here
