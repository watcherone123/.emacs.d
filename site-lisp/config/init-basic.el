
;; ** Full name and Email (Can not use use-package)
(setq user-full-name "watcherone123")
(setq user-mail-address "watcherone123@gmail.com")

;; ** 启动时默认打开的 buffer. (Can not use use-package)
(setq inhibit-startup-screen t)
(setq initial-buffer-choice nil)
(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message
      ";; This is *scratch* buffer.\n\n")

;; ** 使用空格缩进 (Can not use use-package)
(setq-default indent-tabs-mode nil)

;; ** 关闭 beep (Can not use use-package)
(setq visible-bell t)

;; ** 使用英文 day-name, 而不是中文： “星期XX”
(setq system-time-locale "C")

(setq ring-bell-function 'ignore);;禁用响铃


;; ** 设置 emacs 包管理器 (Can not use use-package)
(require 'package)
(setq use-package-always-ensure nil)
(unless package--initialized
  (package-initialize))


(setq package-archives
      `(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
        ("org-cn"   . "http://elpa.emacs-china.org/org/")
        ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))

;; ** 使用 use-package
(setq use-package-verbose 'errors)
(require 'use-package)

 
(use-package mule
  :ensure nil
  :config
  (set-language-environment "UTF-8")
  (set-buffer-file-coding-system 'utf-8-unix)
  (set-clipboard-coding-system 'utf-8-unix)
  (set-file-name-coding-system 'utf-8-unix)
  (set-keyboard-coding-system 'utf-8-unix)
  (set-next-selection-coding-system 'utf-8-unix)
  (set-selection-coding-system 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)

  (when (eq system-type 'windows-nt)
    (set-language-environment "Chinese-GBK")
    (set-selection-coding-system 'gbk-dos)
    (set-next-selection-coding-system 'gbk-dos)
    (set-clipboard-coding-system 'gbk-dos)))

;;关闭指针闪动
(use-package frame
  :ensure nil
  :config
  (blink-cursor-mode -1)
  ;;配置窗口标题
  (setq frame-title-format
	'((:eval (if (buffer-file-name)
		     (abbreviate-file-name (buffer-file-name))
		   "%b"))))

  )
;; ** 保存文件之前，删除无用的空格
(use-package files
  :ensure nil
  :config

  ;; Window 系统下关闭 Emacs 时，强制确认，防止误操作。
  (when (eq system-type 'windows-nt)
    (setq confirm-kill-emacs 'yes-or-no-p))

  ;; ** 关闭自动备份功能，我有 git :-)
  (setq make-backup-files nil))

(use-package whitespace
  :ensure nil
  :config
  ;; 使用下面这一行配置后，org-mode 的源代码总是莫名其妙的
  ;;     (add-hook 'before-save-hook #'whitespace-cleanup)
  ;; 更改，这会导致生成的 diff 相当乱。
  )

;; ** 设置 recentf
(use-package recentf
  :ensure nil
  :bind (("C-x f" . recentf-open-files))
  :config
  (setq recentf-auto-cleanup 'never)
  (recentf-mode 1)
  (setq recentf-max-saved-items 99)
  (setq recentf-max-menu-items 99)
  (setq recentf-show-file-shortcuts-flag nil)
  (setq recentf-exclude
        '("COMMIT" "autoloads" "archive-contents" "eld" "newsrc"
          ".recentf" "emacs-font-size.conf"
          "pyim-dcache-.*"))
  ;; 自动保存recentf文件。
  (add-hook 'find-file-hook #'recentf-save-list))

;; ** 设置 ibuffer
(use-package ibuffer
  :ensure nil
  :bind (("C-x b" . ibuffer)))

;; ** 关闭 tool-bar
(use-package tool-bar
  :ensure nil
  :bind (("C-x k" . kill-this-buffer))
  :config
  (tool-bar-mode -1))

;; ** 关闭 menu-bar
(use-package menu-bar
  :ensure nil
  :bind (("C-x k" . kill-this-buffer))
  :config
  (menu-bar-mode 0))

;; ** 关闭 scroll-bar
(use-package scroll-bar
  :ensure nil
  :config
  (scroll-bar-mode -1))

;; ** 配对括号高亮显示
(use-package paren
  :ensure nil
  :config
  (show-paren-mode 1))

;; ** 括号自动匹配
(use-package elec-pair
  :ensure nil
  :config
  (electric-pair-mode 1))

(use-package watcher-funcs
  :ensure nil
  :commands (
             watcher/split-window-horizontally 
             watcher/split-window-vertically
             watcher/kill-this-buffer
             watcher/kill-other-buffers 
             watcher/switch-to-scratch-buffer 
             watcher/switch-to-messages-buffer 
             watcher/copy-file 
             watcher/show-and-copy-buffer-filename 
             watcher/rename-current-buffer-file 
             watcher/last-buffer 
             watcher/delete-window 
             toggle-window-split 
             watcher/indent-region-or-buffer 
             watcher-toggle-letter-case 
             watcher/find-user-init-file 
             watcher-clean-empty-lines 
             watcher-open-in-external-app 
             ))
(provide 'init-basic)
