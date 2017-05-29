(defun watcher/ivy-search-engine-select ()
  "Set search engine to use with ivy."
  (interactive)
  (ivy-read "Search Engines: "
	    (mapcar (lambda (engine)
		      (cons (plist-get (cdr engine) :name)
			    (intern (format "engine/search-%S"
					    (car engine)))))
		    search-engine-alist)
	    :action (lambda (candidate) (call-interactively (cdr candidate)))))


(use-package engine-mode
  :ensure t
  :commands ( watcher/ivy-search-engine-select)
  :init
  (progn
    (spacemacs-keys-set-leader-keys
      "a/" 'watcher/ivy-search-engine-select)
    (setq search-engine-alist
	  '(
	    (google
	     :name "Google"
	     :url "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s") 
	    (baidu
	     :name "baidu"
	     :url "http://www.baidu.com/s?wd=%s")
	    (emacs
	     :name "emacs"
	     :url "https://emacs-china.org/search?q=%s")
	    (google-images
	     :name "Google Images"
	     :url "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s")
	    (github
	     :name "Github"
	     :url "https://github.com/search?ref=simplesearch&q=%s")
	    (youtube
	     :name "YouTube"
	     :url "http://www.youtube.com/results?aq=f&oq=&search_query=%s")
	    (stack-overflow
	     :name "Stack Overflow"
	     :url "https://stackoverflow.com/search?q=%s")
	    (wikipedia
	     :name "Wikipedia"
	     :url "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s")
	    (wolfram-alpha
	     :name "Wolfram Alpha"
	     :url "http://www.wolframalpha.com/input/?i=%s")))
    (dolist (engine search-engine-alist)
      (let ((func (intern (format "engine/search-%S" (car engine)))))
	(autoload func "engine-mode" nil 'interactive))))
  :config
  (progn
    (engine-mode t)
    (dolist (engine search-engine-alist)
      (let* ((cur-engine (car engine))
	     (engine-url (plist-get (cdr engine) :url)))
	(eval `(defengine ,cur-engine ,engine-url)))))
  )

(provide 'watcher-web)
