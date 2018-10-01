(use-package evil
  :ensure t
  :diminish undo-tree-mode
  
  :config
  (evil-mode 1)
  (setq evil-default-cursor t)
  (define-key evil-insert-state-map (kbd "\C-a") 'evil-first-non-blank)
  (define-key evil-insert-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  (define-key evil-normal-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  (spacemacs-keys-set-leader-keys
    "t u" 'undo-tree-visualize
    )
  )

(use-package evil-nerd-commenter
  :ensure t
  :commands (evilnc-comment-operator)
  :init
  (spacemacs-keys-set-leader-keys
    ";"  'evilnc-comment-operator
    )
  )

(provide 'init-evil)
