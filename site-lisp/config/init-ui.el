(use-package window-numbering
  :ensure t
  :defer t
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
  ;; (setq monokai-foreground monokai-violet )
  (load-theme 'monokai  t)
  )

(use-package popwin
  :ensure t
  :defer t
  :commands (popwin-mode)
  :init
  (popwin-mode 1))



(use-package awesome-tray
  :ensure nil
  :defer 0.01
  :config
  (awesome-tray-mode 1))


;; (setq-default cursor-type 'bar)
(global-hl-line-mode 1);;高亮当前行

(provide 'init-ui)
