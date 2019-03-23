(use-package company
  :diminish company-mode
  :ensure t
  :defer 0.1
  :config
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
  :ensure nil
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
(provide 'init-company)

