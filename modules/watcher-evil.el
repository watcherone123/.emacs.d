(use-package evil
  :ensure t
  :diminish undo-tree-mode
  :config
  (evil-mode 1)
  (setq evil-default-cursor t)
  (define-key evil-insert-state-map (kbd "\C-a") 'evil-first-non-blank)
  (define-key evil-insert-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  (define-key evil-normal-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  )

(use-package evil-nerd-commenter
  :ensure t
  :commands (evilnc-comment-operator)
  :init
  (spacemacs-keys-set-leader-keys
    ";"  'evilnc-comment-operator
    )
  )

(use-package multiple-cursors
  :defer t
  :ensure t
  :config
  ;; {{ multiple-cursors
  ;; step 1, select thing in visual-mode (OPTIONAL)
  ;; step 2, `mc/mark-all-like-dwim' or `mc/mark-all-like-this-in-defun'
  ;; step 3, `ace-mc-add-multiple-cursors' to remove cursor, press RET to confirm
  ;; step 4, press s or S to start replace
  ;; step 5, press C-g to quit multiple-cursors
  (define-key evil-visual-state-map (kbd "mn") 'mc/mark-next-like-this)
  (define-key evil-visual-state-map (kbd "ma") 'mc/mark-all-like-this-dwim)
  (define-key evil-visual-state-map (kbd "md") 'mc/mark-all-like-this-in-defun)
  (define-key evil-visual-state-map (kbd "mm") 'ace-mc-add-multiple-cursors)
  (define-key evil-visual-state-map (kbd "ms") 'ace-mc-add-single-cursor)
  ;; }}
  )

(provide 'watcher-evil)
