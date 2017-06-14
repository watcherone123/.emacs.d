(use-package macrostep
  :defer t
  :ensure t
  :init
  (spacemacs-keys-declare-prefix-for-mode 'emacs-lisp-mode
					    "me" "eval"
					    )
  (define-key emacs-lisp-mode-map (kbd "C-c e") 'macrostep-expand)
  (spacemacs-keys-set-leader-keys-for-major-mode 'emacs-lisp-mode
    "ee" 'macrostep-expand
    "eq" 'macrostep-collapse-all
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
(defun watcher/lisp-keybindings ()
      (spacemacs-keys-set-leader-keys-for-major-mode 'emacs-lisp-mode
      "eb" 'eval-buffer
      "er" 'eval-region
      "eu" 'update-file-autoloads
      )
    )
(add-hook 'emacs-lisp-mode-hook 'watcher/lisp-keybindings)
(provide 'watcher-lisp)
