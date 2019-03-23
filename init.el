(defvar best-gc-cons-threshold 40000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)
;; ;;声明一些路径便于后续迁移
(defvar watcher-emacs-root-dir (file-truename "~/.emacs.d/site-lisp"))
(defvar watcher-emacs-config-dir (concat watcher-emacs-root-dir "/config"))
(defvar watcher-emacs-extension-dir (concat watcher-emacs-root-dir "/extensions"))
(defvar watcher-cache-directory (expand-file-name ".cache" watcher-emacs-root-dir))
(make-directory watcher-cache-directory t)
(setq recentf-save-file (expand-file-name "recentf" watcher-cache-directory))

(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(add-subdirs-to-load-path "~/.emacs.d/site-lisp/")

(let ((file-name-handler-alist nil))
  (with-temp-message ""
    ;;核心必要插件
    (require 'init-basic)
    (require 'init-evil)
    (require 'init-ui)
    (require 'init-awesome-tab)
    (require 'spacemacs-keys)
    ;;(require 'init-hydra)
    (require 'init-ivy)
    (require 'init-keys)
    (require 'init-dired)
    (require 'init-search)
    (require 'init-company)
    (require 'init-gtags)
    ;;(require 'init-font)

    (require 'init-shell)
    (require 'init-misc)
    ;;(require 'init-edit)
    ;;(require 'init-paredit)
    ;;(require 'init-company)
    ;; (require 'init-python)
    ;;(require 'init-gtags)

    )
  )
;;定制文件加载
(use-package cus-edit
  :ensure nil
  :config
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (load custom-file :no-error :no-message))
 
(setq gc-cons-threshold best-gc-cons-threshold)
