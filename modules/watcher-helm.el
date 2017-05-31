(use-package helm-ag
  :defer t
  :ensure t
  :init
  (setq tramp-ssh-controlmaster-options
	"-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  :config
  (custom-set-variables
   '(helm-ag-base-command "pt -e --nocolor --nogroup"))

  )

(provide 'watcher-helm)
