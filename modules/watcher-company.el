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
  ;; (define-key yas-minor-mode-map (kbd "M-s-/") 'yas-next-field)
  ;; (global-set-key (kbd "M-/") 'yas-expand-from-trigger-key)
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
  ;; :defer t
  ;; :commands (company-complete)
  :init
  (global-company-mode)
  :config
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

  ;; (add-to-list 'company-backends
  ;;	       '(company-capf company-dabbrev company-files
  ;;			      company-dabbrev-code company-gtags
  ;;			      company-keywords
  ;;			      ))
  (setq company-backends
	'((company-capf company-dabbrev company-files)
	  (company-dabbrev-code company-gtags company-etags
				company-keywords)))

 (setq company-transformers
	'(company-sort-by-occurrence))

  (setq company-frontends
	'(company-pseudo-tooltip-frontend
	  company-echo-metadata-frontend))

  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p")'company-select-previous)
  (global-set-key (kbd "M-1") 'company-files)
  ;; (global-set-key (kbd "M-/") 'company-complete)
  )

(use-package hippie-exp
  :config
  (setq hippie-expand-try-function-list '(try-expand-debbrev
					  try-expand-debbrev-all-buffers
					  try-expand-debbrev-from-kill
					  try-complete-file-name-partially
					  try-complete-file-name
					  try-expand-all-abbrevs
					  try-expand-list
					  try-expand-line
					  try-complete-lisp-symbol-partially
					  try-complete-lisp-symbol))
  (global-set-key (kbd "M-/") 'hippie-expand)
  (define-key evil-insert-state-map [remap evil-complete-previous] 'hippie-expand)
  )

(defun watcher/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))


(provide 'watcher-company)
