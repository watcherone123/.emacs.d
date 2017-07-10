(clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(
    ("8wa" "watcher")
    ("8em" "watcherone123@gmail.com")
    )
  )

(set-default 'abbrev-mode t)

(setq save-abbrevs nil)
