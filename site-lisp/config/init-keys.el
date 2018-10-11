
(use-package which-key
  :defer t
  :init
  (add-hook 'after-init-hook 'which-key-mode)
  :diminish
  (which-key-mode
   undo-tree-mode
   )
  :ensure t
  :config
  (progn
    (setq which-key-special-keys nil
	  which-key-use-C-h-for-paging t
	  which-key-prevent-C-h-from-cycling t
	  which-key-echo-keystrokes 0.02
	  which-key-max-description-length 32
	  which-key-sort-order 'which-key-key-order-alpha
	  which-key-idle-delay 0.4
	  which-key-allow-evil-operators t)

    (add-to-list 'which-key-description-replacement-alist
		 (cons (rx bos "cb" (* (not (any "/"))) "/" (group (+ nonl)) eos) "\\1"))
    (which-key-add-key-based-replacements
      "SPC a"   "appliction"
      "SPC a s" "shell" 
      "SPC b"   "buffers"
      "SPC f"   "files"
      "SPC f e" "emacs"
      "SPC f b" "bookmarks"
      "SPC p"   "projects"
      "SPC h"   "help"
      "SPC w"   "window"
      "SPC SPC" "M-x"
      "SPC q"   "quit "
      "SPC g"   "git"
      "SPC o"   "watcher"
      "SPC v"   "visual"
      "SPC x"   "text"
      "SPC t"   "toggle"
      "SPC m"   '("major-mode-cmd" . "Major mode commands")
      )
    ;; (which-key-setup-side-window-right-bottom)
    )

  )


(use-package spacemacs-keys
  :defer t
  :config
  (spacemacs-keys-set-leader-keys
    "SPC" 'smex
    "="  'watcher/indent-region-or-buffer
    "TAB" 'watcher/last-buffer
    ;; "/" 'helm-do-ag
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4

    "a l" 'counsel-colors-emacs
    "a r" 'calendar
    "a c" 'calc
    "asn" 'aweshell-new
    "ast" 'aweshell-toggle
    "a p" 'esup

    "b b" 'ivy-switch-buffer
    "b o" 'ivy-switch-buffer-other-window
    "b w" 'read-only-mode
    "b s" 'watcher/switch-to-scratch-buffer
    "b m" 'watcher/switch-to-messages-buffer
    "b d" 'watcher/kill-this-buffer
    "b p" 'previous-buffer
    "b n" 'next-buffer
    "b C-d" 'watcher/kill-other-buffers

    "f f" 'counsel-find-file
    "f r" 'counsel-recentf
    "f J" 'dired-jump-other-window
    "f j" 'dired-jump
    "f o" 'watcher-open-in-external-app
    ;; "fbb" 'counsel-bookmark
    ;; "fbm" 'bookmark-set
    ;; "fbd" 'bookmark-delete
    ;; "fbj" 'bookmark-jump
    "f c" 'watcher/copy-file
    "f y" 'watcher/show-and-copy-buffer-filename
    "f R" 'watcher/rename-current-buffer-file
    "fei" 'watcher/find-user-init-file
    "fec" 'watcher/find-core-file
    "fem" 'watcher/find-modules-file
    "gb"  'magit-blame+
    "gcc" 'magit-commit-absorb-popup
    "gca" 'magit-commit-amend
    "gff" 'magit-find-file
    "gfl" 'magit-log-buffer-file
    "gfd" 'magit-diff-buffer-file-popup
    "g,"  'magit-init
    "gl"  'magit-log-all
    "gs"  'magit-status
    "gma" 'magit-submodule-add+
    "gmd" 'magit-submodule-remove+
    "gml" 'magit-list-submodule
    "gd"  'magit-discard
    "gu"  'magit-push-current-to-upstream
    "gi"  'magit-pull-from-upstream

    "vl" 'watcher-clean-empty-lines
    "vb" 'awesome-tab-select-beg-tab
    "ve" 'awesome-tab-select-end-tab
    "vg" 'awesome-tab-switch-group
    "vn" 'awesome-tab-forward-tab
    "vp" 'awesome-tab-backward-tab
    "vo" 'awesome-tab-kill-other-buffers-in-current-group
    "va" 'awesome-tab-kill-all-buffers-in-current-group
   

    "t l" 'linum-mode
    "t c" 'watcher-toggle-letter-case
    "t m" 'toggle-menu-bar-mode-from-frame

    "q q" 'save-buffers-kill-terminal
    "w /" 'watcher/split-window-horizontally
    "w -" 'watcher/split-window-vertically
    "w d" 'watcher/delete-window
    "w o" 'delete-other-windows
    "w =" 'balance-windows
    "w t" 'toggle-window-split

    "h f" 'counsel-describe-function
    "h v" 'counsel-describe-variable
    "h l" 'counsel-find-library
    "h p" 'describe-package
    "h k" 'describe-key
    "h m" 'describe-mode
    )
  )
(provide 'init-keys)
