
(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  )

;; (use-package monokai-theme
;;   :ensure t
;;   :config
;;   (setq monokai-foreground monokai-violet )
;;   (load-theme 'monokai  t)
;;   )

;; ** cyberpunk-theme
(use-package cyberpunk-theme
  :ensure t
  :config
  (add-hook 'after-init-hook
            #'(lambda ()
                (load-theme 'cyberpunk t)
                ;; Adjust cyberpunk theme
                (set-face-attribute 'font-lock-comment-face nil :italic nil)
                (set-face-attribute 'org-agenda-date-today nil :slant 'normal))))

(use-package popwin
  :ensure t
  :defer t
  :commands (popwin-mode)
  :init
  (popwin-mode 1))



;;(use-package awesome-tray
  ;;:ensure nil
  ;;:config
  ;;(awesome-tray-mode 1))

(provide 'init-ui)
