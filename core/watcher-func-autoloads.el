;;; watcher-func-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "watcher-func" "watcher-func.el" (22828 15132
;;;;;;  0 0))
;;; Generated autoloads from watcher-func.el

(autoload 'watcher/kill-this-buffer "watcher-func" "\
Kill the current buffer.
If the universal prefix argument is used then kill also the window.

\(fn &optional ARG)" t nil)

(autoload 'watcher/kill-other-buffers "watcher-func" "\
Kill all other buffers.
If the universal prefix argument is used then will the windows too.

\(fn &optional ARG)" t nil)

(autoload 'watcher/switch-to-scratch-buffer "watcher-func" "\
Switch to the `*scratch*' buffer. Create it first if needed.

\(fn)" t nil)

(autoload 'watcher/switch-to-messages-buffer "watcher-func" "\
Switch to the `*Messages*' buffer.
if prefix argument ARG is given, switch to it in an other, possibly new window.

\(fn &optional ARG)" t nil)

(autoload 'watcher/copy-file "watcher-func" "\
Write the file under new name.

\(fn)" t nil)

(autoload 'watcher/show-and-copy-buffer-filename "watcher-func" "\
Show and copy the full path to the current file in the minibuffer.

\(fn)" t nil)

(autoload 'watcher/rename-current-buffer-file "watcher-func" "\
Renames current buffer and file it is visiting.

\(fn)" t nil)

(autoload 'watcher/last-buffer "watcher-func" "\
Switch back and forth between current and last buffer in the
current window.

\(fn &optional WINDOW)" t nil)

(autoload 'watcher/delete-window "watcher-func" "\
Delete the current window.
If the universal prefix argument is used then kill the buffer too.

\(fn &optional ARG)" t nil)

(autoload 'watcher/indent-region-or-buffer "watcher-func" "\
Indent a region if selected, otherwise the whole buffer.

\(fn)" t nil)

;;;***

(provide 'watcher-func-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; watcher-func-autoloads.el ends here
