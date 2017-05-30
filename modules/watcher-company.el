(use-package yasnippet
  :defer t
  :ensure t
  :commands (yas-global-mode yas-minor-mode)
  :init
  (setq yas-triggers-in-field t
	yas-wrap-around-region t
	)
  (setq yas-prompt-functions '(yas-completing-prompt))
  (setq yas-minor-mode-map (make-sparse-keymap))


  ;;this make it easy to get out of a nested expansion
  (define-key yas-minor-mode-map (kbd "M-s-/") 'yas-next-field)
  (global-set-key (kbd "M-/") 'yas-expand-from-trigger-key)
  (defun watcher/load-yasnippt ()
    (unless yas-global-mode (yas-global-mode 1))
    (yas-minor-mode)

    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
    )

  (add-hook 'prog-mode-hook 'watcher/load-yasnippt)
  (add-hook 'org-mode-hook 'watcher/load-yasnippt)
  (add-hook 'markdown-mode-hook 'watcher/load-yasnippt)

  )
(use-package company-auctex
  :defer t
  :ensure t
  :config
  (add-hook 'latex-mode-hook '(lambda ()
				(add-to-list 'company-backends
					     '( company-auctex-labels
						company-auctex-bibs company-auctex-macros
						company-auctex-symbols company-auctex-environments
						))
				))
  (company-auctex-init)
  )

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
	    '(:with company-yasnippet))))

(use-package company
  :ensure t
  :defer t
  :commands (global-company-mode)
  :init
  (global-company-mode)
  (setq company-dabbrev-downcase nil
	;; make previous/next selection in the popup cycles
	company-selection-wrap-around t
	;; Some languages use camel case naming convention,
	;; so company should be case sensitive.
	company-dabbrev-ignore-case nil
	;; press M-number to choose candidate
	company-show-numbers t
	company-idle-delay 0.2
	company-require-match nil
	)
  :config
  (add-to-list 'company-backends
	       '(company-capf company-dabbrev company-files
			      company-dabbrev-code company-gtags company-etag
			      company-keywords
			      ))
  ;; (setq company-backends
  ;;	'((company-capf company-dabbrev company-files)
  ;;	  (company-dabbrev-code company-gtags company-etags
  ;;				company-keywords)))
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p")'company-select-previous)

  )


(provide 'watcher-company)
