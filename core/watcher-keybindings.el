(require 'spacemacs-keys)
(use-package bind-map
  :defer t
  :ensure t)

(use-package which-key
  :defer t
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
      "SPC b"   "buffers"
      "SPC f"   "files"
      "SPC p"   "projects"
      "SPC h"   "help"
      "SPC w"   "window"
      "SPC SPC" "M-x"
      "SPC q"   "quit "
      "SPC g"   "git"
      "SPC o"   "watcher"
      "SPC t"   "toggle"
      "SPC m"   '("major-mode-cmd" . "Major mode commands")
      )
    (which-key-mode)
    ;; (which-key-setup-side-window-right-bottom)
    )

  )

(use-package spacemacs-keys
  :defer t
  :config
  (spacemacs-keys-set-leader-keys
    "="  'watcher/indent-region-or-buffer
    "TAB" 'watcher/last-buffer
    "/" 'helm-do-ag
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4

    "a l" 'counsel-colors-emacs
    "a r" 'calendar
    "a c" 'calc
    "a e" 'eshell

    "b b" 'ivy-switch-buffer
    "b o" 'ivy-switch-buffer-other-window
    "b w" 'read-only-mode
    "b s" 'watcher/switch-to-scratch-buffer
    "b m" 'watcher/switch-to-messages-buffer
    "b d" 'watcher/kill-this-buffer
    "b p" 'previous-buffer
    "b n" 'next-buffer
    "b C-d" 'watcher/kill-other-buffers

    "f J" 'dired-jump-other-window
    "f j" 'dired-jump
    "f c" 'watcher/copy-file
    "f y" 'watcher/show-and-copy-buffer-filename
    "f R" 'watcher/rename-current-buffer-file

    "t l" 'linum-mode

    "q q" 'save-buffers-kill-terminal
    "w /" 'split-window-right
    "w -" 'split-window-below
    "w d" 'watcher/delete-window
    "w o" 'delete-other-windows
    "w =" 'balance-windows

    "h p" 'describe-package
    "h k" 'which-key-show-top-level
    )
  )
(global-set-key (kbd "C-M-\\") 'watcher/indent-region-or-buffer)  
(provide 'watcher-keybindings)
