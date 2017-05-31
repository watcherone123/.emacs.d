(use-package window-numbering
  :ensure t
  :defer t
  :commands (window-numbering-mode)
  :init
  (window-numbering-mode))

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
  :ensure t)

(use-package spaceline-config
  :ensure spaceline
  :defer t
  :commands (spaceline-spacemacs-theme)
  :init
  (spaceline-spacemacs-theme)

  :config
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  )

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
;;配置窗口标题
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))
(provide 'watcher-ui)
