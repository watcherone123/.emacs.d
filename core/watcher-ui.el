(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init

  (load-theme watcher-theme t)

  )

(use-package highlight-parentheses 
  :diminish highlight-parentheses-mode
  :ensure t
  :config
    (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  )

(use-package spaceline
  :ensure t)

(use-package spaceline-config
  :ensure spaceline
  :config

  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-spacemacs-theme))

(use-package smartparens-config
  :defer 0.1
  :diminish smartparens-mode
  :ensure smartparens

  :config
  (progn
    (show-smartparens-global-mode t)
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    )
  (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
  (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
  )

(use-package golden-ratio
  :defer 0.1
  :ensure t
  :config
  (require 'watcher-keybindings)
  (spacemacs-keys-set-leader-keys
    "wg" 'golden-ratio-mode
    )
  )

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))
;;配置窗口标题
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))
(provide 'watcher-ui)
