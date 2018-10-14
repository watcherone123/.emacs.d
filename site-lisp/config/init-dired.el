(use-package dired+
  :ensure nil
  :defer 0.2
  :commands (global-dired-hide-details-mode)
  :config 
  (setq dired-dwim-target t)
  )

(provide 'init-dired)
