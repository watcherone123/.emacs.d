;; ** cnfonts
(use-package cnfonts
  :ensure t
  :demand t
  :if (display-graphic-p)
  :init (setq cnfonts-verbose nil)
  :config
  (setq cnfonts-use-face-font-rescale
        (eq system-type 'gnu/linux))
  (cnfonts-enable)
  :bind (("C--" . cnfonts-decrease-fontsize)
         ("C-+" . cnfonts-increase-fontsize)
         ;;("C-+" . cnfonts-next-profile)
         ))

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode)
  )
(use-package esup
  :ensure t
  :commands esup)

(provide 'init-misc)
