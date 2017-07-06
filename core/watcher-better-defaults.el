;;------------------ UI配置----------------
(and (bound-and-true-p tool-bar-mode)
     (tool-bar-mode -1))
(and (bound-and-true-p scroll-bar-mode)
     (scroll-bar-mode -1))

;;启动最大化
(progn
  (unless (frame-parameter nil 'fullscreen)
    (toggle-frame-maximized)
    )
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  )

;; )

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
;; 设置默认文件路径
(setq default-directory "~/workspace")

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
;;	       '(("[pP][lL][iI][nN][kK]" gbk-dos . gbk-dos)
;;		 ("[cC][mM][dD][pP][rR][oO][xX][yY]" gbk-dos . gbk-dos))))

;; force horizontal split window
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(use-package autorevert
  :ensure nil
  :diminish auto-revert-mode)

(use-package bookmark                   ; Bookmarks for Emacs buffers
  :bind (("C-c f b" . list-bookmarks))
  ;; Save bookmarks immediately after a bookmark was added
  :config (setq bookmark-save-flag 1
		bookmark-default-file (expand-file-name "bookmarks" watcher-cache-directory)))

(use-package saveplace                  ; Save point position in files
  :init (save-place-mode 1)
  :config
  (progn
    (setq-default save-place t)
    (setq-default save-place-file (expand-file-name "places" watcher-cache-directory))))

(use-package advance-words-count
  :load-path "site-lisp/advance-words-count/"
  :defer t
  :commands (advance-words-count)
  )

(provide 'watcher-better-defaults)
