(use-package chinese-fonts-setup
  :ensure t
  :defer t
  :init
  (set-face-attribute
   'default nil
   :font (font-spec :name "-outline-Source Code Pro-bold-italic-normal-mono-*-*-*-*-c-*-iso10646-1"
		    :weight 'normal
		    :slant 'normal
		    :size 12.5))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name "-outline-微软雅黑-bold-normal-normal-sans-*-*-*-*-p-*-iso10646-1"
		:weight 'normal
		:slant 'normal
		:size 15.0)))
  ;; (chinese-fonts-setup-enable)

  )

(use-package youdao-dictionary
  :ensure t
  :defer t
  :commands (youdao-dictionary-search-at-point+)
  :init
  ;; (setq url-automatic-caching t)
  (with-eval-after-load 'watcher-keybindings
    (spacemacs-keys-set-leader-keys
      " o y" 'youdao-dictionary-search-at-point+)
    )
  )
(use-package esup
  :ensure t
  :defer t
  )

(provide 'watcher-misc)
