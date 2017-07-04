(use-package winum
  :ensure t
  :defer t
  :commands (winum-mode)
  :init
  (setq winum-auto-setup-mode-line nil)
  (add-hook 'after-init-hook 'winum-mode)
  )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme watcher-theme t)
  :config
  (custom-theme-set-faces 'sanityinc-tomorrow-night
			  `(region ((t :background "magenta"))))
  )
(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  )

(use-package spaceline
  :defer t
  :ensure t)

(use-package spaceline-config
  :ensure spaceline
  ;; :disabled t
  :defer t
  :commands (spaceline-spacemacs-theme )
  :init
  (spaceline-spacemacs-theme)
  :config
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  )


(use-package all-the-icons
  :ensure t
  :defer t
  :init
  (set-frame-font "all-the-icons" t)
  :config
  (set-frame-font "Source Code Pro" t)
  )

(use-package all-the-icons-dired
  :ensure t
  :defer t
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

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

(use-package neotree
  :ensure t
  :defer t
  :commands (neotree-toggle)
  :init
  (progn
    (setq neo-window-width 32
	  neo-create-file-auto-open t
	  neo-show-updir-line nil
	  neo-mode-line-type 'neotree
	  neo-smart-open t
	  neo-dont-be-alone t
	  neo-persist-show nil
	  neo-show-hidden-files t
	  neo-auto-indent-point t
	  neo-modern-sidebar t
	  neo-vc-integration nil)
    (require 'watcher-keybindings)
    (spacemacs-keys-set-leader-keys
      "ft" 'neotree-toggle
      )
    )
  :config
  (setq neo-theme (if window-system 'icons 'arrow))
  (defun watcher/set-keybinds-for-neotree ()
    (with-eval-after-load 'evil
      (evil-define-key 'normal  neotree-mode-map (kbd "q") 'neotree-hide)
      (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
      (evil-define-key 'normal neotree-mode-map (kbd "gr") 'neotree-refresh)
      (evil-define-key 'normal neotree-mode-map (kbd "j") 'neotree-next-line)
      (evil-define-key 'normal neotree-mode-map (kbd "k") 'neotree-previous-line)
      (evil-define-key 'normal neotree-mode-map (kbd "K") 'neotree-select-up-node)
      (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
      )
    )

  (watcher/set-keybinds-for-neotree)
  )
        
(use-package popwin
  :ensure t
  :defer t
  :commands (popwin-mode)
  :init
  (popwin-mode 1))

(use-package whitespace-cleanup-mode
  :ensure t
  :diminish whitespace-cleanup-mode
  :defer t
  :init
  (global-whitespace-cleanup-mode t))

;;配置窗口标题
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))
(provide 'watcher-ui)
