(use-package org
  :defer t
  :ensure t
  :init
  (setq org-log-done t
	org-startup-with-inline-images t
	org-image-actual-width nil
	org-src-fontify-natively t
	org-imenu-depth 8)
  ;; Follow the confirm and abort conventions
  (with-eval-after-load 'org-capture
    (spacemacs-keys-set-leader-keys-for-minor-mode 'org-capture-mode
      spacemacs-keys-major-mode-leader-key 'org-capture-finalize
      "a" 'org-capture-kill
      "c" 'org-capture-finalize
      "k" 'org-capture-kill
      "R" 'org-capture-refile))


  (with-eval-after-load 'org-src
    (spacemacs-keys-set-leader-keys-for-minor-mode 'org-src-mode
      spacemacs-keys-major-mode-leader-key 'org-edit-src-exit
      "c" 'org-edit-src-exit
      "a" 'org-edit-src-abort
      "k" 'org-edit-src-abort))


  (defun watcher/insert-keybinding-org (key)
    "Ask for a key then insert its description.
Will work on both org-mode and any mode that accepts plain html."
    (interactive "kType key sequence: ")
    (let* ((tag "@@html:<kbd>@@ %s @@html:</kbd>@@"))
      (if (null (equal key "\r"))
	  (insert
	   (format tag (help-key-description key nil)))
	(insert (format tag ""))
	(forward-char -8))))

  (dolist (prefix '(("me" . "export")
		    ("mx" . "text")
		    ("mi" . "insert")
		    ("mt" . "tables")
		    ("mtd" . "delete")
		    ("mti" . "insert")
		    ("mtt" . "toggle")))
    (spacemacs-keys-declare-prefix-for-mode 'org-mode (car prefix) (cdr prefix)))

  (spacemacs-keys-set-leader-keys-for-major-mode 'org-mode
    "'" 'org-edit-special
    "c" 'org-capture
    "d" 'org-deadline
    "D" 'org-insert-drawer
    "ee" 'org-export-dispatch
    "f" 'org-set-effort
    "P" 'org-set-property
    ":" 'org-set-tags

    "a" 'org-agenda
    "A" 'org-archive-subtree
    "l" 'org-open-at-point

    "." 'org-time-stamp
    "!" 'org-time-stamp-inactive


    ;; Change between TODO sets
    "C-S-l" 'org-shiftcontrolright
    "C-S-h" 'org-shiftcontrolleft
    "C-S-j" 'org-shiftcontroldown
    "C-S-k" 'org-shiftcontrolup


    ;; tables
    "ta" 'org-table-align
    "tb" 'org-table-blank-field
    "tc" 'org-table-convert
    "tdc" 'org-table-delete-column
    "tdr" 'org-table-kill-row
    "te" 'org-table-eval-formula
    "tE" 'org-table-export
    "th" 'org-table-previous-field
    "tH" 'org-table-move-column-left
    "tic" 'org-table-insert-column
    "tih" 'org-table-insert-hline
    "tiH" 'org-table-hline-and-move
    "tir" 'org-table-insert-row
    "tI" 'org-table-import
    "tj" 'org-table-next-row
    "tJ" 'org-table-move-row-down
    "tK" 'org-table-move-row-up
    "tl" 'org-table-next-field
    "tL" 'org-table-move-column-right
    "tn" 'org-table-create
    "tN" 'org-table-create-with-table.el
    "tr" 'org-table-recalculate
    "ts" 'org-table-sort-lines
    "ttf" 'org-table-toggle-formula-debugger
    "tto" 'org-table-toggle-coordinate-overlays
    "tw" 'org-table-wrap-region

    ;; Multi-purpose keys
    (or spacemacs-keys-major-mode-leader-key ",") 'org-ctrl-c-ctrl-c
    "*" 'org-ctrl-c-star
    "RET" 'org-ctrl-c-ret
    "-" 'org-ctrl-c-minus
    "^" 'org-sort
    "/" 'org-sparse-tree
    "I" 'org-clock-in
    ;; insertion
    "ia" 'org-attach
    "il" 'org-insert-link
    "if" 'org-footnote-new
    "ik" 'watcher/insert-keybinding-org

    "n" 'org-narrow-to-subtree
    "N" 'widen
    "O" 'org-clock-out
    "q" 'org-clock-cancel
    "R" 'org-refile
    "s" 'org-schedule

    )

  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)

  :config
  ;; the Emacs user unable to exit src block editing.
  (define-key org-src-mode-map
    (kbd (concat spacemacs-keys-major-mode-leader-key " '"))
    'org-edit-src-exit)

  (spacemacs-keys-set-leader-keys "Cc" 'org-capture)

  (setq org-src-fontify-natively t)
  (with-eval-after-load 'org
    (progn
      ;; (spacemacs/set-leader-keys-for-major-mode 'org-mode
      ;;   "," 'org-priority)
      (require 'org-compat)
      (require 'org)
      (add-to-list 'org-modules 'org-habit)
      (require 'org-habit)

      (setq org-refile-use-outline-path 'file)
      (setq org-outline-path-complete-in-steps nil)
      (setq org-refile-targets
	    '((nil :maxlevel . 4)
	      (org-agenda-files :maxlevel . 4)))

      ;; config stuck project
      (setq org-stuck-projects
	    '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE:"))

      (setq org-agenda-inhibit-startup t) ;; ~50x speedup
      (setq org-agenda-span 'day)
      (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
      (setq org-agenda-window-setup 'current-window)
      (setq org-log-done t)
      )
    )
  )

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("STARTED" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold)
	      ("SOMEDAY" :foreground "forest green" :weight bold)
	      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t) ;; Show the clocked-in task - if any - in the header line

(setq org-tags-match-list-sublevels nil)
(defvar org-agenda-dir ""
  "gtd org files location")

(setq-default
 org-agenda-dir "~/workspace/org-notes"
 )
;; define the refile targets
(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
(setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
(setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
(setq org-default-notes-file (expand-file-name "gtd.org" org-agenda-dir))
(setq org-agenda-files (list org-agenda-dir))


;; (with-eval-after-load 'org-agenda
;;   (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)
;;   (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
;;     "." 'spacemacs/org-agenda-transient-state/body)
;;   )


(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Workspace")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)
	("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
	 "* %?\n  %i\n %U"
	 :empty-lines 1)
	("b" "Blog Ideas" entry (file+headline org-agenda-file-note "Blog Ideas")
	 "* TODO [#B] %?\n  %i\n %U"
	 :empty-lines 1)
	("s" "Code Snippet" entry
	 (file org-agenda-file-code-snippet)
	 "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
	("w" "work" entry (file+headline org-agenda-file-gtd "毕业设计")
	 "* TODO [#A] %?\n  %i\n %U"
	 :empty-lines 1)
	("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
	 "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
	 :empty-lines 1)
	("l" "links" entry (file+headline org-agenda-file-note "Quick notes")
	 "* TODO [#C] %?\n  %i\n %a \n %U"
	 :empty-lines 1)
	("j" "Journal Entry"
	 entry (file+datetree org-agenda-file-journal)
	 "* %?"
	 :empty-lines 1)))

;;An entry without a cookie is treated just like priority ' B '.
;;So when create new task, they are default 重要且紧急
(setq org-agenda-custom-commands
      '(
	("w" . "任务安排")
	("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
	("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
	("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
	("b" "Blog" tags-todo "BLOG")
	("p" . "项目安排")
	("W" "Weekly Review"
	 ((stuck "") ;; review stuck projects as designated by org-stuck-projects
	  (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
	  ))))

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))) )

(use-package org-agenda
  :defer t
  :ensure nil
  :init
  (progn
    (setq org-agenda-restore-windows-after-quit t)
    (spacemacs-keys-set-leader-keys-for-major-mode 'org-agenda-mode
      ":" 'org-agenda-set-tags
      "a" 'org-agenda
      "d" 'org-agenda-deadline
      "f" 'org-agenda-set-effort
      "I" 'org-agenda-clock-in
      "O" 'org-agenda-clock-out
      "P" 'org-agenda-set-property
      "q" 'org-agenda-clock-cancel
      "R" 'org-agenda-refile
      "s" 'org-agenda-schedule)
    )

  )

(use-package org-download
  :ensure t
  :commands (org-download-enable
	     org-download-yank
	     org-download-screenshot)
  :init
  (progn
    (add-hook 'org-mode-hook 'org-download-enable)
    (spacemacs-keys-set-leader-keys-for-major-mode 'org-mode
      "iy" 'org-download-yank
      "is" 'org-download-screenshot))
  )
 (require 'ox-publish)
(add-to-list 'org-latex-classes '("ctexart" "\\documentclass[11pt]{ctexart}
					[NO-DEFAULT-PACKAGES]
					\\usepackage[utf8]{inputenc}
					\\usepackage[T1]{fontenc}
					\\usepackage{fixltx2e}
					\\usepackage{graphicx}
					\\usepackage{longtable}
					\\usepackage{float}
					\\usepackage{wrapfig}
					\\usepackage{rotating}
					\\usepackage[normalem]{ulem}
					\\usepackage{amsmath}
					\\usepackage{textcomp}
					\\usepackage{marvosym}
					\\usepackage{wasysym}
					\\usepackage{amssymb}
					\\usepackage{booktabs}
					\\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
					\\tolerance=1000
					\\usepackage{listings}
					\\usepackage{xcolor}
					\\lstset{
					%行号
					numbers=left,
					%背景框
					framexleftmargin=10mm,
					frame=none,
					%背景色
					%backgroundcolor=\\color[rgb]{1,1,0.76},
					backgroundcolor=\\color[RGB]{245,245,244},
					%样式
					keywordstyle=\\bf\\color{blue},
					identifierstyle=\\bf,
					numberstyle=\\color[RGB]{0,192,192},
					commentstyle=\\it\\color[RGB]{0,96,96},
					stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
					%显示空格
					showstringspaces=false
					}
					"
				  ("\\section{%s}" . "\\section*{%s}")
				  ("\\subsection{%s}" . "\\subsection*{%s}")
				  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
				  ("\\paragraph{%s}" . "\\paragraph*{%s}")
				  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-default-class "ctexart")
(setq org-latex-pdf-process
      '(
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"rm -fr %b.out %b.log %b.tex auto"))

(setq org-latex-listings t)
(provide 'watcher-org)
