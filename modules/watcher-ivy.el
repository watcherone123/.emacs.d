(require 'spacemacs-keys)
(use-package ivy
  :defer t
  :commands (ivy-recentf ivy-read)
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
  :bind
  ("C-x C-f" . counsel-find-file)
  ("C-c C-r". counsel-recentf)
  ("M-x" . counsel-M-x)
  ("C-h f" . counsel-describe-function)
  ("C-h v". counsel-describe-variable)
  )
(use-package recentf
  :defer t
  :config
  )

(use-package spacemacs-keys
  :defer t
  :config
  (spacemacs-keys-set-leader-keys
    "SPC" 'counsel-M-x
    "f f" 'counsel-find-file
    "f r" 'counsel-recentf
    "h f" ' counsel-describe-function
    "h v" 'counsel-describe-variable
    "h l" 'counsel-find-library
    )
  )
(use-package swiper
  :defer t
  :ensure t
  :bind
  ("C-s" . swiper)
  )

(use-package smex
  :defer t
  :ensure t
  :config
  (setq smex-save-file (expand-file-name "smex" watcher-cache-directory))
  )



(provide 'watcher-ivy)
