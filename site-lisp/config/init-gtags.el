(use-package ggtags
  :ensure t
  :defer t
  :init
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		(ggtags-mode 1))))
  :config
  (define-key ggtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key ggtags-mode-map (kbd "C-x 4 .") 'helm-gtags-find-tag-other-window)
  (define-key ggtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key ggtags-mode-map (kbd "M-*") 'helm-gtags-pop-stack)

  )

(defun helm-gtags-dwim-other-window ()
  "helm-gtags-dwim in the other window"
  (interactive)
  (let ((helm-gtags--use-otherwin t)
	(split-height-threshold nil)
	(split-width-threshold 140))
    (helm-gtags-dwim)))
;; (defun helm-gtags-dwim

(defun watcher/helm-gtags-define-keys-for-mode (mode)
  "Define key bindings for the specific MODE."
  (when (fboundp mode)
    (spacemacs-keys-set-leader-keys-for-major-mode mode
      ;; "gC" 'counsel-gtags-create-tags
      ;; "gd" 'counsel-gtags-find-definition
      ;; "gr" 'counsel-gtags-find-reference
      ;; "gs" 'counsel-gtags-find-symbol
      ;; "gu" 'counsel-gtags-update-tags
      ;; "gg" 'counsel-gtags-dwim
      ;; "gG" 'counsel-gtags-dwim-other-window
      ;; "gn" 'counsel-gtags-go-forward
      ;; "gp" 'counsel-gtags-go-backward

      "gc" 'helm-gtags-create-tags
      "gd" 'helm-gtags-find-tag
      "gD" 'helm-gtags-find-tag-other-window
      "gf" 'helm-gtags-select-path
      "gG" 'helm-gtags-dwim-other-window
      "gi" 'helm-gtags-tags-in-this-function
      "gl" 'helm-gtags-parse-file
      "gn" 'helm-gtags-next-history
      "gp" 'helm-gtags-previous-history
      "gr" 'helm-gtags-find-rtag
      "gR" 'helm-gtags-resume
      "gs" 'helm-gtags-select
      "gS" 'helm-gtags-show-stack
      "gu" 'helm-gtags-update-tags
      )
    )
  )


(use-package helm-gtags
  :ensure t
  :defer t
  :init
  (progn
    (setq helm-gtags-ignore-case t
	  helm-gtags-auto-update t
	  helm-gtags-use-input-at-cursor t
	  helm-gtags-pulse-at-cursor t)

    (watcher/helm-gtags-define-keys-for-mode 'c-mode)
    (watcher/helm-gtags-define-keys-for-mode 'c++-mode)
    (watcher/helm-gtags-define-keys-for-mode 'java-mode)
    )
  )


;; (use-package counsel-gtags
;;   :ensure t
;;   :defer t
;;   :init
;;   (progn
;;     (add-hook 'c-mode-hook 'counsel-gtags-mode)
;;     (add-hook 'c++-mode-hook 'counsel-gtags-mode)
;;     )
;;   :config
;;   (watcher/counsel-gtags-define-keys-for-mode 'c-mode)
;;   (watcher/counsel-gtags-define-keys-for-mode 'c++-mode)
;;   )

;;   "counsel-gtags-dwim in the other window"
;;   (interactive)
;;   (let ((helm-gtags--use-otherwin t)
;;	(split-height-threshold nil)
;;	(split-width-threshold 140))
;;     (counsel-gtags-dwim)))
(provide 'init-gtags)
