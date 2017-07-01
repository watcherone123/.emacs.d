(use-package flycheck
  :ensure t
  :defer t
  )
(use-package python
  :ensure t
  :defer t
  :mode ("\\.py\\'" . python-mode))

(use-package  ein
  :ensure t
  :defer t
  )

(use-package highlight-indentation
  :ensure t
  :defer t
  :diminish (highlight-indentation-mode)
  )
(use-package elpy
  :ensure t
  :after python
  :config
  (progn
    (elpy-enable)
    (elpy-use-ipython)
    (when (require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))

    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
    (spacemacs-keys-declare-prefix-for-mode 'python-mode "me" "error")
    (spacemacs-keys-declare-prefix-for-mode 'python-mode "mg" "definition")
    (spacemacs-keys-set-leader-keys-for-major-mode 'python-mode
      "h" 'elpy-doc
      "c"  'elpy-test
      "ev" 'elpy-check
      "en" 'flycheck-next-error
      "ep" 'flycheck-previous-error
      "gd" 'elpy-goto-definition
      "gD" 'elpy-goto-definition-other-window
      )
    )
  )

(use-package py-autopep8
  :ensure t
  :defer t
  )

(use-package yapfify
  :ensure t
  :defer t
  :init
  (progn
    (spacemacs-keys-set-leader-keys-for-major-mode 'python-mode
      "=" 'yapfify-buffer
      )
    )
  )

(use-package company-anaconda
  :ensure t
  :defer t
  :init
  (add-hook 'python-mode-hook '(lambda ()
				 (watcher/local-push-company-backend 'company-anaconda)
				 ))
  )

(use-package live-py-mode
  :ensure t
  :defer t
  :commands live-py-mode
  :init
  (spacemacs-keys-set-leader-keys-for-major-mode 'python-mode
    "l" 'live-py-mode
    ))
(provide 'watcher-python)

                        
