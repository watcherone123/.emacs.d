(use-package dired+
  :ensure t
  :commands (dired-jump-other-window dired-jump)
  :config
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-dwim-target t)
  )
(provide 'watcher-dired)
