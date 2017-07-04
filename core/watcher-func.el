;; our own implementation of kill-this-buffer from menu-bar.el
;;;###autoload
(defun watcher/kill-this-buffer (&optional arg)
  "Kill the current buffer.
If the universal prefix argument is used then kill also the window."
  (interactive "P")
  (if (window-minibuffer-p)
      (abort-recursive-edit)
    (if (equal '(4) arg)
	(kill-buffer-and-window)
      (kill-buffer))))

;; found at http://emacswiki.org/emacs/KillingBuffers
;;;###autoload
(defun watcher/kill-other-buffers (&optional arg)
  "Kill all other buffers.
If the universal prefix argument is used then will the windows too."
  (interactive "P")
  (when (yes-or-no-p (format "Killing all buffers except \"%s\"? "
			     (buffer-name)))
    (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
    (when (equal '(4) arg) (delete-other-windows))
    (message "Buffers deleted!")))

;;;###autoload
(defun watcher/switch-to-scratch-buffer ()
  "Switch to the `*scratch*' buffer. Create it first if needed."
  (interactive)
  (let ((exists (get-buffer "*scratch*")))
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (let ((mode 'lisp-interaction-mode))
      (funcall mode))
    ))
;;;###autoload
(defun watcher/switch-to-messages-buffer (&optional arg)
  "Switch to the `*Messages*' buffer.
if prefix argument ARG is given, switch to it in an other, possibly new window."
  (interactive "P")
  (with-current-buffer (messages-buffer)
    (goto-char (point-max))
    (if arg
	(switch-to-buffer-other-window (current-buffer))
      (switch-to-buffer (current-buffer)))))

;;;###autoload
(defun watcher/copy-file ()
  "Write the file under new name."
  (interactive)
  (call-interactively 'write-file))

;;;###autoload
(defun watcher/show-and-copy-buffer-filename ()
  "Show and copy the full path to the current file in the minibuffer."
  (interactive)
  ;; list-buffers-directory is the variable set in dired buffers
  (let ((file-name (or (buffer-file-name) list-buffers-directory)))
    (if file-name
	(message (kill-new file-name))
      (error "Buffer not visiting a file"))))

;;;###autoload
;; from magnars
(defun watcher/rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
	 (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(error "Buffer '%s' is not visiting a file!" name)
      (let* ((dir (file-name-directory filename))
	     (new-name (read-file-name "New name: " dir)))
	(cond ((get-buffer new-name)
	       (error "A buffer named '%s' already exists!" new-name))
	      (t
	       (let ((dir (file-name-directory new-name)))
		 (when (and (not (file-exists-p dir)) (yes-or-no-p (format "Create directory '%s'?" dir)))
		   (make-directory dir t)))
	       (rename-file filename new-name 1)
	       (rename-buffer new-name)
	       (set-visited-file-name new-name)
	       (set-buffer-modified-p nil)
	       (when (fboundp 'recentf-add-file)
		 (recentf-add-file new-name)
		 (recentf-remove-if-non-kept filename))
	       (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

;;;###autoload
(defun watcher/last-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window."
  (interactive)
  (let ((current-buffer (window-buffer window))
	(buffer-predicate
	 (frame-parameter (window-frame window) 'buffer-predicate)))
    ;; switch to first buffer previously shown in this window that matches
    ;; frame-parameter `buffer-predicate'
    (switch-to-buffer
     (or (cl-find-if (lambda (buffer)
		       (and (not (eq buffer current-buffer))
			    (or (null buffer-predicate)
				(funcall buffer-predicate buffer))))
		     (mapcar #'car (window-prev-buffers window)))
	 ;; `other-buffer' honors `buffer-predicate' so no need to filter
	 (other-buffer current-buffer t)))))

;;;###autoload
(defun watcher/delete-window (&optional arg)
  "Delete the current window.
If the universal prefix argument is used then kill the buffer too."
  (interactive "P")
  (if (equal '(4) arg)
      (kill-buffer-and-window)
    (delete-window)))

;;;###autoload
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))


(defvar watcher-indent-sensitive-modes
  '(asm-mode
    coffee-mode
    elm-mode
    haml-mode
    haskell-mode
    slim-mode
    makefile-mode
    makefile-bsdmake-mode
    makefile-gmake-mode
    makefile-imake-mode
    python-mode
    yaml-mode)
  "Modes for which auto-indenting is suppressed.")

;;;###autoload
(defun watcher/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (unless (member major-mode watcher-indent-sensitive-modes)
    (save-excursion
      (if (region-active-p)
	  (progn
	    (indent-region (region-beginning) (region-end))
	    (message "Indented selected region."))
	(progn
	  (evil-indent (point-min) (point-max))
	  (message "Indented buffer.")))
      (whitespace-cleanup))))

;;;###autoload
(defun watcher-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.
"
  (interactive)
  (let (
	(deactivate-mark nil)
	-p1 -p2)
    (if (use-region-p)
	(setq -p1 (region-beginning)
	      -p2 (region-end))
      (save-excursion
	(skip-chars-backward "[:alnum:]-_")
	(setq -p1 (point))
	(skip-chars-forward "[:alnum:]-_")
	(setq -p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region -p1 -p2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region -p1 -p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region -p1 -p2)
      (put this-command 'state 0)))))

;;;###autoload
(defun watcher/find-user-init-file ()
  "Edit the `user-init-file', in the current window."
  (interactive)
  (find-file-existing user-init-file))

;;;###autoload
(defun watcher/find-core-file ()
  "Edit the `core-file', in the current window."
  (interactive)
  (find-file-existing "~/.emacs.d/core/"))

;;;###autoload
(defun watcher/find-modules-file ()
  "Edit the `modules-file', in the current window."
  (interactive)
  (find-file-existing "~/.emacs.d/modules/"))

;;;###autoload
(defun watcher-clean-empty-lines (&optional *begin *end *n)
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

*N is the number of newline chars to use in replacement.
If 0, it means lines will be joined.
By befault, *N is 2. It means, 1 visible blank line.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-01-27"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (when (not *begin)
    (setq *begin (point-min) *end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (progn
	(goto-char (point-min))
	(while (re-search-forward "\n\n\n+" nil "NOERROR")
	  (replace-match (make-string (if *n *n 2) 10)))))))

;;;###autoload
(defun watcher-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2016-10-15"
  (interactive)
  (let* (
         (-file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (-do-it-p (if (<= (length -file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when -do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (-fpath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" -fpath t t))) -file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (-fpath)
           (shell-command
            (concat "open " (shell-quote-argument -fpath))))  -file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (-fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" -fpath))) -file-list))))))

(provide 'watcher-func)
