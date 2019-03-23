(use-package smex
  :ensure t
  :bind ("M-x" . smex)
  :config
  (setq smex-save-file (expand-file-name "smex" watcher-cache-directory))
  )

(provide 'init-smex)
