(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

;; ;; Speed up startup
;; (defvar default-file-name-handler-alist file-name-handler-alist)
;; (setq file-name-handler-alist nil)
;; (setq gc-cons-threshold 80000000)
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             "Restore defalut values after init."
;;             (setq file-name-handler-alist default-file-name-handler-alist)
;;             (setq gc-cons-threshold 800000)
;;             (add-hook 'focus-out-hook 'garbage-collect)))
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
    (require 'init-startup)
    (require 'init-package)
    (require 'init-font)
    (require 'init-basic)
    (require 'init-ui)
    (require 'init-awesome-tab)
    (require 'init-git)
    (require 'spacemacs-keys)
    (require 'init-hydra)
    (require 'watcher-funcs)

    (require 'init-backup)
    (require 'init-evil)
    (require 'init-search)
    (require 'init-dired)
    (require 'init-smex)
    (require 'init-edit)
    (require 'init-paredit)
    (require 'init-ivy)
    (require 'init-company)
    (require 'init-shell)
    ;; (require 'init-python)
    (require 'init-gtags)
    (require 'init-keys)

    )
  )
;;定制文件加载
(use-package cus-edit
  :defer t
  :init
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (load custom-file :no-error :no-message))

(setq gc-cons-threshold best-gc-cons-threshold)
