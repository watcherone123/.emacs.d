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
  (spacemacs-keys-set-leader-keys
    "t u" 'undo-tree-visualize
    )
  )

(use-package multiple-cursors
  :ensure t
  :defer 0.2
  :config
  (define-key evil-visual-state-map (kbd "mn") 'mc/mark-next-like-this)
  (define-key evil-visual-state-map (kbd "ma") 'mc/mark-all-like-this-dwim)
  (define-key evil-visual-state-map (kbd "md") 'mc/mark-all-like-this-in-defun)
  (define-key evil-visual-state-map (kbd "mm") 'ace-mc-add-multiple-cursors)
  (define-key evil-visual-state-map (kbd "ms") 'ace-mc-add-single-cursor)
  )

(use-package expand-region
  :ensure t
  :init
  
  :defer 0.2
  :bind ("C-=" . er/expand-region))

(defhydra hydra-expand-region (:color pink
					:hint nil)
    "
^Symbol^             ^Pairs^           ^Misc^
^^^^^^^^------------------------------------------------
_w_: word          _i_: inside-quotes      _l_: url
_s_: symbol        _o_: outside-quotes     _e_: email
_f_: function      _j_: inside-pairs       ^ ^
_c_: comment       _k_: outside-pairs      ^ ^
^ ^                ^ ^                     _q_ Quit
"
    ("w" er/mark-word)
    ("s" er/mark-symbol)
    ("f" er/mark-defun)
    ("c" er/mark-comment)
    ("i" er/mark-inside-quotes)
    ("o" er/mark-outside-quotes)
    ("j" er/mark-inside-pairs)
    ("k" er/mark-outside-pairs)
    ("l" er/mark-url)
    ("e" er/mark-email)
    ("q" nil)
    )
(use-package evil-escape
  :ensure t
  :init
  ;; (evil-esc-mode 1)
  ;; (add-hook 'after-init-hook 'evil-esc-mode)
  ;; :defer 0.3
  :config
  (progn
    (add-hook 'emacs-startup-hook 'evil-esc-mode)
    (setq-default evil-escape-delay 0.3)
    (setq-default evil-escape-key-sequence "kj")
    )
  )


(use-package evil-nerd-commenter
  :ensure t
  :commands (evilnc-comment-operator)
  :init
  (spacemacs-keys-set-leader-keys
    ";"  'evilnc-comment-operator
    )
  )

(provide 'init-evil)
