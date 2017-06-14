(use-package dired+
  :ensure t
  :defer t
  :commands (dired-jump global-dired-hide-details-mode)
  :init
  (global-dired-hide-details-mode -1)
  :config 
  (setq dired-dwim-target t)
  )
(provide 'watcher-dired)
