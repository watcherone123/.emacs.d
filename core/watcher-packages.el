(require 'cl)
(require 'package)

;;启动插件源配置
(require 'package)
;;配置插件源
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; set package-user-dir to be relative to Prelude install path
(setq package-user-dir (expand-file-name "elpa" watcher-dir))
(package-initialize)



;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package.el is no longer needed at runtime
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(provide 'watcher-packages)
