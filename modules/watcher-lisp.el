(use-package macrostep
  :defer t
  :ensure t
  :init
  (define-key emacs-lisp-mode-map (kbd "C-c e") 'macrostep-expand)
  (spacemacs-keys-set-leader-keys-for-major-mode 'emacs-lisp-mode
    "e" 'macrostep-expand
    "q" 'macrostep-collapse-all
    )
  )



(provide 'watcher-lisp)
