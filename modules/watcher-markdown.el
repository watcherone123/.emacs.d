;;commenter
;; 这里使用pandoc作为预览引擎http://www.pandoc.org/
;; 修改markdown 的command :pandoc -f markdown -t html --ascii --highlight-style pygments --mathjax


(use-package markdown-mode
  :mode ("\\.m[k]d" . markdown-mode)
  :defer t
  :ensure t
  :config
  (progn
    (add-hook 'markdown-mode-hook 'orgtbl-mode)
    ;; Declare prefixes and bind keys
    (dolist (prefix '(("mc" . "markdown/command")
		      ("mh" . "markdown/header")
		      ("mi" . "markdown/insert")
		      ("ml" . "markdown/lists")
		      ("mx" . "markdown/text")))
      (spacemacs-keys-declare-prefix-for-mode
       'markdown-mode (car prefix) (cdr prefix)))

    ;; bindings here
    (dolist (mode '(markdown-mode gfm-mode))
      (spacemacs-keys-set-leader-keys-for-major-mode mode
	;; Movemen
	"{"   'markdown-backward-paragraph
	"}"   'markdown-forward-paragraph
	;; Completion, and Cycling
	"]"   'markdown-complete
	;; Indentation
	">"   'markdown-indent-region
	"<"   'markdown-exdent-region
	;; Buffer-wide commands
	"c]"  'markdown-complete-buffer
	"cc"  'markdown-check-refs
	"ce"  'markdown-export
	"cm"  'markdown-other-window
	"cn"  'markdown-cleanup-list-numbers
	"co"  'markdown-open
	"cp"  'markdown-preview
	"cv"  'markdown-export-and-preview
	"cw"  'markdown-kill-ring-save
	;; headings
	"hi"  'markdown-insert-header-dwim
	"hI"  'markdown-insert-header-setext-dwim
	"h1"  'markdown-insert-header-atx-1
	"h2"  'markdown-insert-header-atx-2
	"h3"  'markdown-insert-header-atx-3
	"h4"  'markdown-insert-header-atx-4
	"h5"  'markdown-insert-header-atx-5
	"h6"  'markdown-insert-header-atx-6
	"h!"  'markdown-insert-header-setext-1
	"h@"  'markdown-insert-header-setext-2
	;; Insertion of common elements
	"-"   'markdown-insert-hr
	"if"  'markdown-insert-footnote
	"ii"  'markdown-insert-image
	"ik"  'spacemacs/insert-keybinding-markdown
	"iI"  'markdown-insert-reference-image
	"il"  'markdown-insert-link
	"iL"  'markdown-insert-reference-link-dwim
	"iw"  'markdown-insert-wiki-link
	"iu"  'markdown-insert-uri
	;; Element removal
	"k"   'markdown-kill-thing-at-point
	;; List editing
	"li"  'markdown-insert-list-item
	;; region manipulation
	"xb"  'markdown-insert-bold
	"xi"  'markdown-insert-italic
	"xc"  'markdown-insert-code
	"xC"  'markdown-insert-gfm-code-block
	"xq"  'markdown-insert-blockquote
	"xQ"  'markdown-blockquote-region
	"xp"  'markdown-insert-pre
	"xP"  'markdown-pre-region
	;; Following and Jumping
	"N"   'markdown-next-link
	"f"   'markdown-follow-thing-at-point
	"P"   'markdown-previous-link
	"<RET>" 'markdown-jump))

    )
  )


(provide 'watcher-markdown)
