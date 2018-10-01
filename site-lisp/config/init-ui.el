(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode 1)
  )

(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  )

(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai  t)
  )

(use-package popwin
  :ensure t
  :defer t
  :commands (popwin-mode)
  :init
  (popwin-mode 1))

(use-package smartparens-config
  :defer 0.1
  :diminish smartparens-mode
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t)
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    )
  ;;(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
  ;;(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
  )

(setq-default cursor-type 'bar)
(global-hl-line-mode 1);;高亮当前行

(provide 'init-ui)
