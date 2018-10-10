
(use-package ivy
  :defer t
  :commands (ivy-recentf ivy-read)
  :diminish ivy-mode
  :ensure t
  :init
  (add-hook 'after-init-hook 'ivy-mode)
  :bind
  ("C-x b" . ivy-switch-buffer-other-window)
  :config
  (setq enable-recursive-minibuffers t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-virtual-abbreviate 'fullpath)
  )

(use-package counsel
  :defer t
  :ensure t
  :init
  (progn
    (setq-default
     recentf-max-saved-items 1000
     recentf-exclude '("/tmp/" "/ssh:"))
    )
  :bind
  ("C-x C-f" . counsel-find-file)
  ("C-c C-r". counsel-recentf)
  ;;("M-x" . counsel-M-x)
  ("C-h f" . counsel-describe-function)
  ("C-h v". counsel-describe-variable)
  )

(use-package swiper
  :defer t
  :ensure t
  :bind
  ("C-s" . swiper)
  )

(provide 'init-ivy)
