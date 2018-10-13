(use-package smartparens-config
  :defer 0.2
  :diminish smartparens-mode
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t)
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    )
  ;; (add-hook 'emacs-lisp-mode 'turn-on-smartparens-strict-mode)
  ;;(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
  )


(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)

(provide 'init-smartparens)
