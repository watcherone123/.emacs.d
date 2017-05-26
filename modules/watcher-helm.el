(use-package helm-ag
  :defer t
  :ensure t
  :config
  (custom-set-variables
   '(helm-ag-base-command "pt -e --nocolor --nogroup"))
  
  )

(provide 'watcher-helm) 
