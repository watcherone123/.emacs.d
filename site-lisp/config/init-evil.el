(use-package evil
  :ensure t
  :diminish undo-tree-mode
  :config
  (evil-mode 1)
  (setq evil-default-cursor t)
  (setq evil-symbol-word-search t)
  (setq evil-insert-state-cursor '("red" bar))
  (define-key evil-insert-state-map (kbd "\C-a") 'evil-first-non-blank)
  (define-key evil-insert-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  (define-key evil-normal-state-map (kbd "\C-e") 'evil-end-of-visual-line)
  )

;; (use-package multiple-cursors
;;   :ensure t
;;   :after evil
;;   :config
;;   (define-key evil-visual-state-map (kbd "mn") 'mc/mark-next-like-this)
;;   (define-key evil-visual-state-map (kbd "ma") 'mc/mark-all-like-this-dwim)
;;   (define-key evil-visual-state-map (kbd "md") 'mc/mark-all-like-this-in-defun)
;;   (define-key evil-visual-state-map (kbd "mm") 'ace-mc-add-multiple-cursors)
;;   (define-key evil-visual-state-map (kbd "ms") 'ace-mc-add-single-cursor)
;;   )

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region)
  )

;; (use-package hydra
;;   :ensure t
;;   :config
;;   (defhydra hydra-expand-region (:color pink
;;                                         :hint nil)
;;     "
;;         ^Symbol^             ^Pairs^           ^Misc^
;;         ^^^^^^^^------------------------------------------------
;;         _w_: word          _i_: inside-quotes      _l_: url
;;         _s_: symbol        _o_: outside-quotes     _e_: email
;;         _f_: function      _j_: inside-pairs       ^ ^
;;         _c_: comment       _k_: outside-pairs      ^ ^
;;         ^ ^                ^ ^                     _q_ Quit
;;         "
;;     ("w" er/mark-word)
;;     ("s" er/mark-symbol)
;;     ("f" er/mark-defun)
;;     ("c" er/mark-comment)
;;     ("i" er/mark-inside-quotes)
;;     ("o" er/mark-outside-quotes)
;;     ("j" er/mark-inside-pairs)
;;     ("k" er/mark-outside-pairs)
;;     ("l" er/mark-url)
;;     ("e" er/mark-email)
;;     ("q" nil)
;;     )
;;   )


;; (use-package evil-escape
;;   :after evil
;;   :ensure t
;;   :config
;;   (progn
;;     (add-hook 'emacs-startup-hook 'evil-esc-mode)
;;     (setq-default evil-escape-delay 0.3)
;;     (setq-default evil-escape-key-sequence "kj")
;;     )
;;   )


(use-package evil-nerd-commenter
  :ensure t
  :after evil
  )
(use-package symbol-overlay
  :ensure t
  :config
  (global-set-key (kbd "M-i") 'symbol-overlay-put)
  (global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
  (global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
  (global-set-key (kbd "<f7>") 'symbol-overlay-mode)
  (global-set-key (kbd "<f8>") 'symbol-overlay-remove-all)
  )
(provide 'init-evil)
