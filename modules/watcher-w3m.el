(defun v/w3m-save-buffer-to-file ()
  (interactive)
  (let* ((curr (buffer-file-name))
	 (new (read-file-name
	       "Save to file: " nil nil nil
	       (and curr (file-name-nondirectory curr))))
	 (mustbenew (if (and curr (file-equal-p new curr)) 'excl t)))
    (if (use-region-p)
	(write-region (region-beginning) (region-end) new nil nil nil mustbenew)
      (save-restriction
	(widen)
	(write-region (point-min) (point-max) new nil nil nil mustbenew)))))

(defun v/w3m-player-movie ()
  (interactive)
  (let ((link (w3m-anchor)))
    (if (not link)
	(message "The point is not link.")
      (cond ((string-match "/\\/www\\.youtube\\.com\\/watch\/?" link)
	     (message (concat "loading from youtube..." link))
	     (call-process "mpv" nil nil nil link))
	    ((string-match "/\\/www\\.bilibili\\.com\\/video\/" link)
	     (message (concat "loading from bilibili..." link))
	     (call-process "bilidan" nil nil nil link)))
      (message "Sorry, Playback error. please check url."))))

(defun v/w3m-copy-link ()
  (interactive)
  (let ((link (w3m-anchor)))
    (if (not link)
	(message "The point is not link.")
      (kill-new link)
      (message "Copy \"%s\" to clipboard." link))))

(defun v/w3m-open-url (url)
  "Opens url in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.com):" nil nil "google.com" nil )))
  (w3m-goto-url
   (concat "http://" url)))

(defun v/w3m-open-url-new-session (url)
  "Opens url in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.com):" nil nil "google.com" nil )))
  (w3m-goto-url-new-session
   (concat "http://" url)))

(use-package w3m
  :ensure t
  :defer t
  :init
  (progn
    (add-to-list 'exec-path "~/share/w3m")

    (setq browse-url-browser-function 'w3m-goto-url-new-session
	  w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533."
	  w3m-coding-system 'utf-8
	  w3m-file-coding-system 'utf-8
	  w3m-file-name-coding-system 'utf-8
	  w3m-input-coding-system 'utf-8
	  w3m-output-coding-system 'utf-8
	  w3m-terminal-coding-system 'utf-8)

    (spacemacs-keys-set-leader-keys
      "awo" 'v/w3m-open-url
      "awf" 'w3m-find-file
      "aws" 'w3m-search
      )
    )
  :config
  (setq w3m-home-page "https://www.baidu.com")
  ;; W3M Home Page
  (setq w3m-default-display-inline-images t)
  (setq w3m-default-toggle-inline-images t)
  ;; W3M default display images
  (setq w3m-command-arguments '("-cookie" "-F"))
  (setq w3m-use-cookies t)
  ;; W3M use cookies
  (setq browse-url-browser-function 'w3m-browse-url)
  ;; Browse url function use w3m
  (setq w3m-view-this-url-new-session-in-background t)
  ;; W3M view url new session in background
  )

(provide 'watcher-w3m)
