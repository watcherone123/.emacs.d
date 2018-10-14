(use-package paredit
  :ensure nil
  ;; :defer t
  :config
  (dolist (hook (list
		 'c-mode-common-hook
		 'c-mode-hook
		 'c++-mode-hook
		 'java-mode-hook
		 'haskell-mode-hook
		 'emacs-lisp-mode-hook
		 'lisp-interaction-mode-hook
		 'lisp-mode-hook
		 'maxima-mode-hook
		 'ielm-mode-hook
		 'sh-mode-hook
		 'makefile-gmake-mode-hook
		 'php-mode-hook
		 'python-mode-hook
		 'js-mode-hook
		 'go-mode-hook
		 'qml-mode-hook
		 'jade-mode-hook
		 'css-mode-hook
		 'ruby-mode-hook
		 'coffee-mode-hook
		 'rust-mode-hook
		 'qmake-mode-hook
		 'lua-mode-hook
		 'swift-mode-hook
		 ))
    (add-hook hook '(lambda () (paredit-mode 1))))
  )

(defhydra hydra-menu-paredit (:color pink
				     :hint nil)
  "
^Wrap^                        ^Free^           ^Remove^                               ^Join or Split^           ^Move^
^^^^^^^^---------------------------------------------------------------------------------------------------------------
_h_: Wrap Left Object   _,_: Free Left Object      _<_: Remove Paren And Left Object   _j_: Join Sexps         _u_: Move list forward
_l_: Wrap Right Object  _._: Free Right Object     _>_: Remove Paren And Left Object   _k_: Split Sexps        _i_: Move list backward
    ^ ^                      ^ ^                       ^ ^                             _n_: Join next list        ^ ^
    ^ ^                      ^ ^                       ^ ^                             _p_: Join previous list    ^ ^
    ^ ^                      ^ ^                     _q_ Quit                           ^ ^                       ^ ^
"
  ("h" paredit-backward-slurp-sexp)
  ("l" paredit-forward-slurp-sexp)
  ("," paredit-backward-barf-sexp)
  ("." paredit-forward-barf-sexp)
  ("<" paredit-splice-sexp-killing-backward)
  (">" paredit-splice-sexp-killing-forward)
  ("j" paredit-join-sexps)
  ("k" paredit-split-sexp)
  ("n" paredit-join-with-next-list)
  ("p" paredit-join-with-previous-list)
  ("u" paredit-move-list-forward)
  ("i" paredit-move-list-backward)
  ("q" nil)
  )


(provide 'init-paredit)
