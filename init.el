;; 移动总结
;; 字符移动 h j k l
;; 单词移动 w e b W E B
;; 行内移动 M-a M-e f ;
;; 段落移动 n m %
;; 屏幕移动 H M L
;; 全文移动 ,ss * gg G C-d C-u
;; 项目移动 ,qq ,md ,mr C-o C-i

(setq w32-get-true-file-attributes nil   ; decrease file IO workload
      w32-use-native-image-API t         ; use native w32 API
      w32-pipe-read-delay 0              ; faster IPC
      w32-pipe-buffer-size (* 64 1024))

(defvar sky-emacs-root-dir (file-truename "~/.emacs.d/site-lisp"))
(defvar sky-emacs-config-dir (concat sky-emacs-root-dir "/config"))
(defvar sky-emacs-pkg-dir (concat sky-emacs-root-dir "/pkg"))

(defvar better-gc-cons-threshold 134217728 ; 128mb
  "The default value to use for `gc-cons-threshold'.
If you experience freezing, decrease this. If you experience stuttering, increase this.")

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defun startup/reset-gc ()
  (setq gc-cons-threshold better-gc-cons-threshold
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/reset-gc)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)

(defun gc-minibuffer-setup-hook ()
  (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

(defun gc-minibuffer-exit-hook ()
  (garbage-collect)
  (setq gc-cons-threshold better-gc-cons-threshold))

(add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)

(add-hook 'emacs-startup-hook
          (lambda ()
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))))



(setq read-process-output-max (* 1024 1024))
(setq confirm-kill-processes nil)
(setq ffap-machine-p-known 'reject)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . 10)))
(setq mouse-wheel-progressive-speed nil)
(delete-selection-mode 1)
(global-auto-revert-mode 1) ;; 自动加载外部修改过的文件

(set-default-coding-systems 'utf-8)
(set-language-environment "UTF-8")
(modify-coding-system-alist 'process "[cC][mM][dD][pP][rR][oO][xX][yY]" '(chinese-gbk-dos . chinese-gbk-dos))

(defun open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f12>") 'open-init-file)

(defun open-newline-below (arg)
  "Move to the next line (like vi) and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (call-interactively 'next-line arg)
  (if (not (member major-mode '(haskell-mode org-mode literate-haskell-mode)))
      (indent-according-to-mode)
    (beginning-of-line)))


(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)

;; 包设置
(require 'package)
;; (setq package-archives '(("gnu"    . "http://mirrors.bfsu.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "http://mirrors.bfsu.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "http://mirrors.bfsu.edu.cn/elpa/melpa/")))
(setq package-archives '(("gnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")))

;; Initialize packages
(unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
(setq use-package-always-ensure t)
(require 'use-package)

(add-to-list 'prog-mode-hook #'hs-minor-mode)

(use-package no-littering)

(use-package custom
  :ensure nil
  :no-require t
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file)))

;;  consolas:11 + 更纱黑体 SC:10.5
(use-package cnfonts
  :ensure t
  :config (progn
	    (cnfonts-mode 1)
	    (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
	    (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
	    (setq cnfonts-personal-fontnames '(() ("更纱黑体 SC") () () ()))
	    ))

(use-package expand-region
  :ensure t
  :commands (er/expand-region er/contract-region)
  )

(setq dired-listing-switches "-alh")

(global-so-long-mode 1)

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq inable-recursive-minibuffers t ; Allow commands in minibuffers
	      history-length 1000
	      savehist-additional-variables '(mark-ring
					      global-mark-ring
					      search-ring
					      regexp-search-ring
					      extended-command-history)
	      savehist-autosave-interval 300)
  )

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))

(use-package org
  :ensure t
  :bind ("C-c C-a" . org-agenda)
  :config (setq org-agenda-files '("~/gtd.org")))

(use-package ef-themes
  :ensure t
  :config
  (ef-themes-select 'ef-duo-light)
  )

(use-package recentf
  :ensure nil
  :custom
  (recentf-max-saved-items 300)
  (recentf-auto-cleanup 'never)
  :config (recentf-mode t))

(use-package helpful
  :ensure t
  :bind (
	 ("C-h f" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h k" . helpful-key)
	 ("C-h a" . apropos)
	 )
  )

(use-package elisp-demos
  :ensure t
  :after (helpful)
  :config (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))

(use-package web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)))

(use-package vertico
  :ensure t
  :config
  (vertico-mode t)
  (define-key minibuffer-local-map (kbd "M-<backspace>") #'vertico-directory-up)
  )

(use-package orderless
  :ensure t
  :after (vertico)
  :init (setq completion-styles '(orderless)))

(use-package marginalia
  :after (vertico)
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t
  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; 多个#二次过滤，!筛选
(use-package consult
  :ensure t
  :bind("C-s" . consult-line)
  )

(use-package winum
  :defer 1
  :ensure t
  :config (winum-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package undohist
  :ensure t
  :init
  (setq undohist-ignored-files '("\\.git/COMMIT_EDITMSG$"))
  :config
  (undohist-initialize)
  )

;; evil最好以行为单位进行编辑，否则撤销时之前的内容都没了
(use-package vundo
  :defer 3
  :after (evil)
  :ensure t)


(use-package counsel-etags
  :ensure t
  :init (setq counsel-etags-grep-extra-arguments "-g !\"TAGS\"")
  :commands (counsel-etags-list-tag counsel-etags-scan-code counsel-etags-grep)
  )

(use-package format-all
  :ensure t
  :commands (format-all-buffer))

(use-package yasnippet
  :defer 8
  :ensure t
  :init
  (setq yas-verbosity 0)
  :config (yas-global-mode t)
  )

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))

(use-package markdown-mode
  :ensure t)

(setq lsp-bridge-get-project-path-by-filepath
      (lambda (filepath)
        (when (locate-dominating-file filepath ".myproject")
	  (expand-file-name (locate-dominating-file filepath ".myproject")))))

;; pip install epc orjson sexpdata six paramiko
(use-package lsp-bridge
  :load-path "site-lisp/pkg/lsp-bridge"
  :init

  (add-to-list 'prog-mode-hook 'lsp-bridge-mode)
  :config
  (require'lsp-bridge)
  (add-to-list 'lsp-bridge-multi-lang-server-extension-list '(("html") . "html_emmet"))
  (add-to-list 'lsp-bridge-multi-lang-server-extension-list '(("css") . "css_emmet"))
  (setq lsp-bridge-python-command "python")
  (setq acm-enable-quick-access t)
  )

(use-package auto-save
  :load-path "site-lisp/pkg/auto-save"
  :config
  (require 'auto-save)
  (auto-save-enable)
  (setq auto-save-silent t)   ; quietly save
  (setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving
  (setq auto-save-disable-predicates
	'((lambda ()
	    (string-suffix-p
	     "gpg"
	     (file-name-extension (buffer-name)) t))))
  )

(defun consult-directory-externally (file)
  (interactive)
  (shell-command-to-string (encode-coding-string (replace-regexp-in-string "/" "\\\\"
									   (format "explorer.exe %s" (file-name-directory (expand-file-name file)))) 'gbk)))
(defun my-open-current-directory ()
  (interactive)
  (consult-directory-externally default-directory))

;; ; 选中后按?还有其他功能
(use-package avy
  :defer 3
  :config (setq avy-timeout-seconds 5)
  :ensure t
  :bind ("C-'" . avy-goto-char-timer))

(use-package projectile
  :ensure t
  :commands (projectile-switch-project projectile-switch-to-buffer projectile-find-file)
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

(use-package counsel
  :ensure t
  :commands (counsel-apropos))

(use-package keycast
  :ensure t
  :commands (keycast-header-line-mode)
  )

(defun smart-q ()
  "Delete window in read-only buffers, otherwise record macro."
  (interactive)
  (if buffer-read-only
      (if (= 1 (count-windows))
          (bury-buffer)
        (delete-window))
    (call-interactively 'evil-record-macro)))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (progn
    (evil-mode 1)
    (setcdr evil-insert-state-map nil)
    (define-key evil-motion-state-map [down-mouse-1] nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    (evil-set-leader '(normal visual motion) (kbd "SPC"))
    ;;(evil-set-leader '(normal visual motion) (kbd "SPC") t)
    (setq evil-move-beyond-eol t)
    (evil-define-key '(normal visual motion) 'global (kbd "RET") 'open-newline-below)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>;") 'evilnc-comment-or-uncomment-lines)
    ;; file
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ff") 'find-file)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>fo") 'find-file-other-window)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>fd") 'my-open-current-directory)

    (evil-define-key '(normal visual motion) 'global (kbd "<leader>fr") 'consult-recent-file)

    ;; buffer
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>bb") 'switch-to-buffer)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>bo") 'switch-to-buffer-other-window)
    ;; (evil-define-key '(normal visual motion) 'global (kbd "<leader>be") (lambda () (interactive) (revert-buffer-with-coding-system 'utf-8)))
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>bk") 'kill-buffer)
    ;; bookmark
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ba") 'consult-bookmark)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>bd") 'bookmark-delete)
    ;;
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ss") 'consult-line)
    ;; (evil-define-key '(normal visual motion) 'global (kbd "<leader>sa") 'blink-search)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>sn") 'consult-imenu)  ;; name
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>sr") 'consult-ripgrep) ;; query
    ;; help
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hf") 'helpful-callable)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hv") 'helpful-variable)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hk") 'helpful-key)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ha") 'counsel-apropos)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hi") 'counsel-info)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hb") 'embark-bindings)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>he") 'shortdoc)  ;; example
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>hs") 'find-function)  ;; source
    ;; project
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>pp") 'projectile-switch-project)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>pb") 'projectile-switch-to-buffer)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>pf") 'projectile-find-file)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>po") 'projectile-find-file-other-window)
    ;; (evil-define-key '(normal visual motion) 'global (kbd "<leader>pq") 'projectile-ripgrep)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>dd") 'dired)
    ;; window
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>1") 'winum-select-window-1)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>2") 'winum-select-window-2)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>3") 'winum-select-window-3)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>4") 'winum-select-window-4)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>wd") 'kill-buffer-and-window)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>wo") 'delete-other-windows)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>w/") 'split-window-right)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>w-") 'split-window-below)
    (evil-define-key '(normal visual motion) 'global (kbd "<localleader>h") 'auto-highlight-symbol-mode)
    (evil-define-key '(normal visual motion) 'global (kbd "<localleader>l") 'toggle-truncate-lines)
    ;; org mode
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>oo") 'org-agenda-list)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>oa") 'org-agenda)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>of") #'(lambda () (interactive) (find-file "~/todo.org")))
    ;; lsp
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>mb") 'quickrun)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>md") 'lsp-bridge-find-def)    ;; go def use lsp-bridge
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>mr") 'lsp-bridge-find-references)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>mo") 'lsp-bridge-popup-documentation)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ma") 'lsp-bridge-diagnostic-list)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>ms") 'lsp-bridge-workspace-list-symbols)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>mf") 'lsp-bridge-code-format)
    ;; misc
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>yy") 'consult-yank-from-kill-ring)
    (evil-define-key '(normal visual motion) 'global "u" (lambda () (interactive) (if (not (fboundp 'vundo)) (evil-undo 1) (vundo) (vundo-backward 1))))
    (evil-define-key '(normal visual motion) 'global "n" 'evil-backward-paragraph)
    (evil-define-key '(normal visual motion) 'global "m" 'evil-forward-paragraph)
    (define-key evil-normal-state-map (kbd "<tab>") 'evil-switch-to-windows-last-buffer)
    (define-key evil-normal-state-map (kbd "q") 'smart-q)
    (define-key evil-normal-state-map (kbd "+") 'er/expand-region)
    (define-key evil-normal-state-map (kbd "-") 'er/contract-region)
    ;; (evil-define-key '(normal visual motion) 'global (kbd "<leader>e") 'one-key-menu-thing-edit)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>tt") 'counsel-etags-find-tag)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>tl") 'counsel-etags-list-tag)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>tg") 'counsel-etags-scan-code)
    (evil-define-key '(normal visual motion) 'global (kbd "<leader>tq") 'counsel-etags-grep)
    (evil-define-key '(normal visual motion insert) 'global (kbd "M-a") 'move-beginning-of-line)
    (evil-define-key '(normal visual motion insert) 'global (kbd "M-e") 'move-end-of-line)

    (evil-define-key 'normal dired-mode-map
      (kbd "<backspace>") 'dired-up-directory
      "`" 'my-open-current-directory
      "o" 'dired-find-file-other-window
      ")" 'dired-omit-mode)
    ))

(cl-loop for (mode . state) in
	 '((org-agenda-mode . normal)
	   (lsp-bridge-ref-mode . emacs)
	   (eshell-mode . emacs)
	   (magit-mode . emacs)
	   )
	 do (evil-set-initial-state mode state))

(use-package evil-anzu
  :ensure t
  :after evil
  :diminish
  :init
  (global-anzu-mode t))

;; define my text object
(evil-define-text-object my-entire-buffer (count &optional beg end type)
  (list (point-min) (point-max)))
(define-key evil-outer-text-objects-map "b" 'my-entire-buffer)
(define-key evil-inner-text-objects-map "b" 'my-entire-buffer)

;; 让 C-o 对 consult-line 生效
(evil-add-command-properties #'consult-line :jump t)

;; v标记区域，R启用iedit
(use-package iedit
  :ensure t
  :init
  (setq iedit-toggle-key-default nil)
  :config
  (define-key iedit-mode-keymap (kbd "M-f") 'iedit-restrict-function)
  (define-key iedit-mode-keymap (kbd "M-l") 'iedit-restrict-current-line))

(use-package evil-multiedit
  :ensure t
  :commands (evil-multiedit-default-keybinds)
  :init
  (evil-multiedit-default-keybinds))

;; 批量替换
(use-package wgrep
  :ensure
  :bind
  (
   :map grep-mode-map
   ("C-c C-w" . wgrep-change-to-wgrep-mode)
   )
  )

;; (define-key lisp-interaction-mode-map (kbd "M-q") 'nil)

(use-package evil-nerd-commenter
  :after (evil)
  :ensure t
  :config (evilnc-default-hotkeys))

;; visual mode : S<textobj>
;; normal : ys<textobj> cs<textobj> ds<textobj>
(use-package evil-surround
  :after (evil)
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; (use-package evil-escape
;;   :after (evil)
;;   :ensure t
;;   :config
;;   (progn
;;     (setq-default evil-escape-delay 0.3)
;;     (setq evil-escape-excluded-major-modes '(dired-mode))
;;     (setq-default evil-escape-key-sequence "kj")
;;     (evil-escape-mode 1)
;;     ))

(use-package evil-snipe
  :ensure t
  :diminish
  :init
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

(use-package evil-matchit
  :ensure
  :init
  (global-evil-matchit-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package shackle
  :ensure t
  :hook (after-init . shackle-mode)
  :init
  (setq shackle-default-alignment 'right))

(use-package magit
  :commands (magit-status magit)
  :ensure t)

(use-package cmake-mode
  :ensure t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
	 ("\\.cmake\\'" . cmake-mode)))

(use-package gn-mode
  :ensure t
  :mode (("\\.gn\\'" . gn-mode)
	 ("\\.gni\\'" . gn-mode))
  )

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode))

(use-package lua-mode
  :ensure t
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode)
  )

(use-package treesit
  :ensure nil
  :config
  ;; M-x `treesit-install-language-grammar` to install language grammar.
  (setq treesit-language-source-alist
	'((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
	  (c . ("https://github.com/tree-sitter/tree-sitter-c"))
	  (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
	  (css . ("https://github.com/tree-sitter/tree-sitter-css"))
	  (cmake . ("https://github.com/uyha/tree-sitter-cmake"))
	  (csharp     . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
	  (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
	  (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
	  (go . ("https://github.com/tree-sitter/tree-sitter-go"))
	  (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
	  (html . ("https://github.com/tree-sitter/tree-sitter-html"))
	  (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
	  (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
	  (json . ("https://github.com/tree-sitter/tree-sitter-json"))
	  (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
	  (make . ("https://github.com/alemuller/tree-sitter-make"))
	  (markdown . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
	  (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
	  (org . ("https://github.com/milisims/tree-sitter-org"))
	  (python . ("https://github.com/tree-sitter/tree-sitter-python"))
	  (php . ("https://github.com/tree-sitter/tree-sitter-php"))
	  (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
	  (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
	  (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
	  (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
	  (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
	  (vue . ("https://github.com/merico-dev/tree-sitter-vue"))
	  (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
	  (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
	  (zig . ("https://github.com/GrayJack/tree-sitter-zig"))))

  (setq major-mode-remap-alist
	'((c-mode          . c-ts-mode)
          (c++-mode        . c++-ts-mode)
          (cmake-mode      . cmake-ts-mode)
          (conf-toml-mode  . toml-ts-mode)
          (css-mode        . css-ts-mode)
          (js-mode         . js-ts-mode)
          (js-json-mode    . json-ts-mode)
          (python-mode     . python-ts-mode)
          (sh-mode         . bash-ts-mode)
          (typescript-mode . typescript-ts-mode)))

  (add-hook 'emacs-lisp-mode-hook #'(lambda () (treesit-parser-create 'elisp)))
  )

(use-package fingertip
  :load-path "site-lisp/pkg/fingertip"
  :config
  ;; (require 'fingertip)
  (dolist (hook (list
		 'c-mode-common-hook
		 'c-mode-hook
		 'c++-mode-hook
		 'java-mode-hook
		 'haskell-mode-hook
		 'emacs-lisp-mode-hook
		 'lisp-interaction-mode-hook
		 'lisp-mode-hook
		 'maxima-mode-hook
		 'ielm-mode-hook
		 'sh-mode-hook
		 'makefile-gmake-mode-hook
		 'php-mode-hook
		 'python-mode-hook
		 'js-mode-hook
		 'go-mode-hook
		 'qml-mode-hook
		 'jade-mode-hook
		 'css-mode-hook
		 'ruby-mode-hook
		 'coffee-mode-hook
		 'rust-mode-hook
		 'rust-ts-mode-hook
		 'qmake-mode-hook
		 'lua-mode-hook
		 'swift-mode-hook
		 'web-mode-hook
		 'markdown-mode-hook
		 'llvm-mode-hook
		 'conf-toml-mode-hook
		 'nim-mode-hook
		 'typescript-mode-hook
		 'c-ts-mode-hook
		 'c++-ts-mode-hook
		 'cmake-ts-mode-hook
		 'toml-ts-mode-hook
		 'css-ts-mode-hook
		 'js-ts-mode-hook
		 'json-ts-mode-hook
		 'python-ts-mode-hook
		 'bash-ts-mode-hook
		 'typescript-ts-mode-hook
		 ))
    (add-hook hook #'(lambda () (fingertip-mode 1))))

  (define-key fingertip-mode-map (kbd "(") 'fingertip-open-round)
  (define-key fingertip-mode-map (kbd "[") 'fingertip-open-bracket)
  (define-key fingertip-mode-map (kbd "{") 'fingertip-open-curly)
  (define-key fingertip-mode-map (kbd ")") 'fingertip-close-round)
  (define-key fingertip-mode-map (kbd "]") 'fingertip-close-bracket)
  (define-key fingertip-mode-map (kbd "}") 'fingertip-close-curly)
  (define-key fingertip-mode-map (kbd "=") 'fingertip-equal)

  (define-key fingertip-mode-map (kbd "（") 'fingertip-open-chinese-round)
  (define-key fingertip-mode-map (kbd "「") 'fingertip-open-chinese-bracket)
  (define-key fingertip-mode-map (kbd "【") 'fingertip-open-chinese-curly)
  (define-key fingertip-mode-map (kbd "）") 'fingertip-close-chinese-round)
  (define-key fingertip-mode-map (kbd "」") 'fingertip-close-chinese-bracket)
  (define-key fingertip-mode-map (kbd "】") 'fingertip-close-chinese-curly)

  (define-key fingertip-mode-map (kbd "%") 'fingertip-match-paren)
  (define-key fingertip-mode-map (kbd "\"") 'fingertip-double-quote)
  (define-key fingertip-mode-map (kbd "'") 'fingertip-single-quote)

  (define-key fingertip-mode-map (kbd "SPC") 'fingertip-space)
  (define-key fingertip-mode-map (kbd "RET") 'fingertip-newline)

  (define-key fingertip-mode-map (kbd "M-o") 'fingertip-backward-delete)
  (define-key fingertip-mode-map (kbd "C-d") 'fingertip-forward-delete)
  (define-key fingertip-mode-map (kbd "C-k") 'fingertip-kill)

  (define-key fingertip-mode-map (kbd "M-\"") 'fingertip-wrap-double-quote)
  (define-key fingertip-mode-map (kbd "M-'") 'fingertip-wrap-single-quote)
  (define-key fingertip-mode-map (kbd "M-[") 'fingertip-wrap-bracket)
  (define-key fingertip-mode-map (kbd "M-{") 'fingertip-wrap-curly)
  (define-key fingertip-mode-map (kbd "M-(") 'fingertip-wrap-round)
  (define-key fingertip-mode-map (kbd "M-)") 'fingertip-unwrap)

  (define-key fingertip-mode-map (kbd "M-p") 'fingertip-jump-right)
  (define-key fingertip-mode-map (kbd "M-n") 'fingertip-jump-left)
  (define-key fingertip-mode-map (kbd "M-:") 'fingertip-jump-out-pair-and-newline)

  (define-key fingertip-mode-map (kbd "C-j") 'fingertip-jump-up)
  )

;; (use-package esup
;;    :ensure t)

(use-package auto-highlight-symbol
  :ensure t
  :config (setq ahs-idle-interval 0)
  :commands (auto-highlight-symbol-mode)
  )

(use-package quickrun
  :commands (quickrun)
  :ensure t)

;; (defun my-cleanup-gc ()
;;   "Clean up gc."
;;   (setq gc-cons-threshold  104857600) ; 100M
;;   (setq gc-cons-percentage 0.1) ; original value
;;   (garbage-collect))
;; (run-with-idle-timer 4 nil #'my-cleanup-gc)
(message "*** Emacs loaded in %s with %d garbage collections."
         (format "%.2f seconds"
                 (float-time (time-subtract after-init-time before-init-time)))
         gcs-done)
