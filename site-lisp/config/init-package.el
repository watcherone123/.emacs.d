(require 'cl)
(require 'package)

;;配置插件源
 (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/")))


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
(setq use-package-inject-hooks t)
(setq use-package-verbose 'errors)
;; (setq use-package-always-ensure t)



(use-package diminish
  :defer t
  :ensure t)

(use-package bind-key
  :defer t
  :ensure t)

(use-package bind-map
  :defer t
  :ensure t)
  
(provide 'init-package)
