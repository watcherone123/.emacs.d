(use-package counsel-projectile
  :ensure t
  :config
  (add-hook 'after-init-hook 'projectile-mode)
  (setq-default
   projectile-mode-line
   '(:eval
     (format "Pr") )
   )
    (setq projectile-known-projects-file (expand-file-name  "projectile-bookmarks.eld" watcher-cache-directory)
          projectile-cache-file (expand-file-name  "projectile.cache" watcher-cache-directory))
  (spacemacs-keys-set-leader-keys
    " p d" 'counsel-projectile-find-dir
    "p D" 'projectile-dired
    "p f" 'counsel-projectile-find-file
    "p F" 'projectile-find-file-dwim
    "p h" 'counsel-projectile
    "p r" 'projectile-recentf
    "p p" 'counsel-projectile-switch-project
    "p s" 'helm-ag-project-root
    )
  )

(provide 'watcher-projectile)
