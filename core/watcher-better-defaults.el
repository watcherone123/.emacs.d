;;------------------ UI配置----------------
(and (bound-and-true-p tool-bar-mode)
     (tool-bar-mode -1))
(and (bound-and-true-p scroll-bar-mode)
     (scroll-bar-mode -1))
;;设置光标样式
					;(setq-default cursor-type 'bar)
;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;;-----------------其它配置--------------
;;禁止响铃
(setq ring-bell-function #'ignore)
(fset 'yes-or-no-p #'y-or-n-p)
;;高亮当前行
(global-hl-line-mode 1)
;;禁止备份
(setq make-backup-files nil)
;;移动更加平滑
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil)            ; don't accelerate scrolling
(setq-default smooth-scroll-margin 0)
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 100000)

;; Charset 设置

(set-language-environment "Chinese-gbk")
(set-buffer-file-coding-system 'chinese-gbk)
(set-clipboard-coding-system 'chinese-gbk)
(set-file-name-coding-system 'chinese-gbk)
(set-keyboard-coding-system 'chinese-gbk)
(set-next-selection-coding-system 'chinese-gbk)
(set-selection-coding-system 'chinese-gbk)
(set-terminal-coding-system 'chinese-gbk)

  ;; (when (eq system-type 'windows-nt)
  ;;   (set-language-environment "Chinese-gbk")
  ;;   (set-selection-coding-system 'gbk-dos)
  ;;   (set-next-selection-coding-system 'gbk-dos)
  ;;   (set-clipboard-coding-system 'gbk-dos))
;; (when (eq system-type 'windows-nt)
;;   (set-default 'process-coding-system-alist
;; 	       '(("[pP][lL][iI][nN][kK]" gbk-dos . gbk-dos)
;; 		 ("[cC][mM][dD][pP][rR][oO][xX][yY]" gbk-dos . gbk-dos))))

;;启动最大化
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; force horizontal split window
(setq split-width-threshold 120)

(use-package autorevert
  :ensure nil
  :diminish auto-revert-mode)
(provide 'watcher-better-defaults)
