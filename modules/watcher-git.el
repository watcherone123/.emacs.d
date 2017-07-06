(use-package magit
  :ensure t
  :defer t
  :init
  (spacemacs-keys-declare-prefix "gf" "file")
  (spacemacs-keys-set-leader-keys
    "g s" 'magit-status
    "g m" 'magit-dispatch-popup
    "g L" 'magit-list-repositories
    "g d" 'magit-diff
    "g f h" 'magit-log-buffer-file
    "g i" 'magit-init
    "g p" 'magit-push
    "g S" 'magit-stage
    )
  )

(provide 'watcher-git)
