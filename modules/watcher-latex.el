(use-package auctex-latexmk
  :ensure t
  :defer t
  :init
  (progn
    (setq auctex-latexmk-inherit-TeX-PDF-mode t)
    (add-hook 'latex-mode-hook 'auctex-latexmk-setup)
    ))

(use-package tex
  :defer t
  :init
  (progn
    (setq TeX-parse-self t
	  TeX-syntactic-comment t
	  ;; Synctex support
	  TeX-source-correlate-start-server nil
	  ;; Don't insert line-break at inline math
	  LaTeX-fill-break-at-separators nil)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode))
  :config
  (progn
    (require 'spacemacs-keys)
    ;;key bindings for plain tex
    (dolist (mode '(tex-mode latex-mode))
      (spacemacs-keys-set-leader-keys-for-major-mode mode
	"\\"  'TeX-insert-macro                            ;; C-c C-m
	"-"   'TeX-recenter-output-buffer                  ;; C-c C-l
	"%"   'TeX-comment-or-uncomment-paragraph          ;; C-c %
	";"   'TeX-comment-or-uncomment-region             ;; C-c ; or

	;; TeX-command-run-all runs compile and open the viewer
	"a"   'TeX-command-run-all                         ;; C-c C-a
	"b"   'latex/build
	"k"   'TeX-kill-job                                ;; C-c C-k
	"l"   'TeX-recenter-output-buffer                  ;; C-c C-l
	"m"   'TeX-insert-macro                            ;; C-c C-m
	"v"   'TeX-view                                    ;; C-c C-v
	;; TeX-doc is a very slow function
	"hd"  'TeX-doc
	"xb"  'latex/font-bold
	"xc"  'latex/font-code
	"xe"  'latex/font-emphasis
	"xi"  'latex/font-italic
	"xr"  'latex/font-clear
	"xo"  'latex/font-oblique
	"xfc" 'latex/font-small-caps
	"xff" 'latex/font-sans-serif
	"xfr" 'latex/font-serif
	)

      (spacemacs-keys-set-leader-keys-for-major-mode mode
	spacemacs-keys-major-mode-leader-key 'TeX-command-master
	)

      (spacemacs-keys-set-leader-keys-for-major-mode mode
	;; the following commands are mostly not autoloaded, but that's fine
	;; because `TeX-fold-mode' is added to `LaTeX-mode-hook'
	"z=" 'TeX-fold-math
	"zb" 'TeX-fold-buffer
	"zB" 'TeX-fold-clearout-buffer
	"ze" 'TeX-fold-env
	"zI" 'TeX-fold-clearout-item
	"zm" 'TeX-fold-macro
	"zp" 'TeX-fold-paragraph
	"zP" 'TeX-fold-clearout-paragraph
	"zr" 'TeX-fold-region
	"zR" 'TeX-fold-clearout-region
	"zz" 'TeX-fold-dwim
	)
      (spacemacs-keys-declare-prefix-for-mode mode "mh" "help")
      (spacemacs-keys-declare-prefix-for-mode mode "mx" "text/fonts")
      (spacemacs-keys-declare-prefix-for-mode mode "mz" "fold")
      )
    ;; Key bindings specific to LaTeX
    (spacemacs-keys-set-leader-keys-for-major-mode 'latex-mode
      "*"   'LaTeX-mark-section      ;; C-c *
      "."   'LaTeX-mark-environment  ;; C-c .
      "c"   'LaTeX-close-environment ;; C-c ]
      "e"   'LaTeX-environment       ;; C-c C-e
      "ii"   'LaTeX-insert-item       ;; C-c C-j
      "s"   'LaTeX-section           ;; C-c C-s
      "fe"  'LaTeX-fill-environment  ;; C-c C-q C-e
      "fp"  'LaTeX-fill-paragraph    ;; C-c C-q C-p
      "fr"  'LaTeX-fill-region       ;; C-c C-q C-r
      "fs"  'LaTeX-fill-section      ;; C-c C-q C-s
      "pb"  'preview-buffer
      "pc"  'preview-clearout
      "pd"  'preview-document
      "pe"  'preview-environment
      "pf"  'preview-cache-preamble
      "pp"  'preview-at-point
      "pr"  'preview-region
      "ps"  'preview-section
      "xB"  'latex/font-medium
      "xr"  'latex/font-clear
      "xfa" 'latex/font-calligraphic
      "xfn" 'latex/font-normal
      "xfu" 'latex/font-upright)
    (spacemacs-keys-declare-prefix-for-mode 'latex-mode "mi" "insert")
    (spacemacs-keys-declare-prefix-for-mode 'latex-mode "mp" "preview")
    (spacemacs-keys-declare-prefix-for-mode 'latex-mode "mf" "fill")
    )
  )

(provide 'watcher-latex)
