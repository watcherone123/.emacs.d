(use-package magit
  :ensure t
  :defer t
  :config
  ;; Magit configuration.
  (setq magit-commit-ask-to-stage nil)    ;don't ask stage question
  (setq magit-display-buffer-noselect t) ;don't select magit buffer default
  ;; Make path column have enough space to display.
  (setq magit-submodule-list-columns
	'(("Path"     80 magit-modulelist-column-path   nil)
	  ("Version"  30 magit-repolist-column-version  nil)
	  ("Branch"   20 magit-repolist-column-branch   nil)
	  ("B<U" 3 magit-repolist-column-unpulled-from-upstream   ((:right-align t)))
	  ("B>U" 3 magit-repolist-column-unpushed-to-upstream     ((:right-align t)))
	  ("B<P" 3 magit-repolist-column-unpulled-from-pushremote ((:right-align t)))
	  ("B>P" 3 magit-repolist-column-unpushed-to-pushremote   ((:right-align t)))
	  ("B"   3 magit-repolist-column-branches                 ((:right-align t)))
	  ("S"   3 magit-repolist-column-stashes                  ((:right-align t)))))

  )

  (defun magit-status+ ()
    (interactive)
    (magit-status)
    (other-window 1))

  (defun magit-blame+ ()
    (interactive)
    (setq magit-blame--style
	  '(margin
	    (margin-format " %s%f" " %C %a" " %H")
	    (margin-width . 42)
	    (margin-face . magit-blame-margin)
	    (margin-body-face magit-blame-dimmed)))
    (magit-blame))

  (defun magit-submodule-add+ (url)
    (interactive "sURL: ")
    (magit-submodule-add
     url
     (concat (file-name-as-directory lazycat-emacs-extension-dir) (file-name-base url))
     (file-name-base url)))

  (defun magit-submodule-remove+ ()
    (interactive)
    (magit-submodule-remove (list (magit-read-module-path "Remove module")) "--force" nil))

(provide 'init-git)
