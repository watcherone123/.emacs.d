(use-package multiple-cursors
  :defer t
  :ensure t
  :init
  (setq-default mc/list-file (expand-file-name ".mc-lists.el" watcher-cache-directory))
  ;; ;; {{ multiple-cursors
  ;; ;; step 1, select thing in visual-mode (OPTIONAL)
  ;; ;; step 2, `mc/mark-all-like-dwim' or `mc/mark-all-like-this-in-defun'
  ;; ;; step 3, `ace-mc-add-multiple-cursors' to remove cursor, press RET to confirm
  ;; ;; step 4, press s or S to start replace
  ;; ;; step 5, press C-g to quit multiple-cursors
  ;; (define-key evil-visual-state-map (kbd "mn") 'mc/mark-next-like-this)
  ;; (define-key evil-visual-state-map (kbd "ma") 'mc/mark-all-like-this-dwim)
  ;; (define-key evil-visual-state-map (kbd "md") 'mc/mark-all-like-this-in-defun)
  ;; (define-key evil-visual-state-map (kbd "mm") 'ace-mc-add-multiple-cursors)
  ;; (define-key evil-visual-state-map (kbd "ms") 'ace-mc-add-single-cursor)
  ;; ;; }}
  (with-eval-after-load 'watcher-keybindings
    (spacemacs-keys-set-leader-keys
      "x a"  'mc/mark-next-like-this
      "x A"  'mc/mark-all-like-this-dwim
      "x j"  'mc/mark-next-like-this
      "x k"  'mc/mark-previous-like-this
      "x d"  'mc/unmark-next-like-this
      "x D"  'mc/unmark-previous-like-this
      ;; "x l"  'mc/edit-lines
      "x b"  'mc/edit-beginnings-of-lines
      "x e"  'mc/edit-ends-of-lines
      )
    )
  )

(use-package symbol-overlay
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'watcher-keybindings
    (spacemacs-keys-set-leader-keys
      "x i" 'symbol-overlay-put
      "x d" 'symbol-overlay-remove-all
      )
    )
  )
(use-package expand-region
  :ensure t
  :defer t
  :commands (er/expand-region)
  :init
  (global-set-key (kbd "C-=") 'er/expand-region)
  )

(provide 'watcher-better-edit)
