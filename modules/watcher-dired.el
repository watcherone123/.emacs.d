(use-package dired+
  :ensure t
  :config
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-dwim-target t)
  )
(provide 'watcher-dired)
