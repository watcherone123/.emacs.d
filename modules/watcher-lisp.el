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

(use-package auto-compile
  :ensure t
  :defer t
  :init
  (progn
    (setq auto-compile-display-buffer nil
	  auto-compile-mode-line-counter t
	  auto-compile-use-mode-line nil)
    (auto-compile-on-load-mode)
    (auto-compile-on-save-mode)
    (add-hook 'emacs-lisp-mode-hook 'auto-compile-mode))
  :config
  (progn
    (spacemacs-keys-set-leader-keys-for-major-mode 'emacs-lisp-mode
      "l" 'auto-compile-display-log
      )
    )
  )

(provide 'watcher-lisp)
