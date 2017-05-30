(defun turnon-keyfreq-mode ()
  (interactive)
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(defun turnoff-keyfreq-mode ()
  (interactive)
  (keyfreq-mode -1)
  (keyfreq-autosave-mode -1))

;; (unless (file-exists-p (file-truename keyfreq-file))
;;   (with-temp-buffer
;;     (insert "()")
;;     (write-file (file-truename keyfreq-file))))

(use-package keyfreq
  :ensure t
  :defer t
  :commands (turnon-keyfreq-mode)
  :init
  (turnon-keyfreq-mode))
 
(provide 'watcher-keyfreq)
