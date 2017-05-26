(defgroup watcher nil
  "Emacs Watcher configuration."
  :prefix "watcher-"
  :group 'convenience)

(defcustom watcher-auto-save t
  "Non-nil values enable Watcher's auto save."
  :type 'boolean
  :group 'watcher)


(defcustom watcher-whitespace t
  "Non-nil values enable Wacther's whitespace visualization."
  :type 'boolean
  :group 'watcher)

(defcustom watcher-clean-whitespace-on-save t
  "Cleanup whitespace from file before it's saved.
Will only occur if `watcher-whitespace' is also enabled."
  :type 'boolean
  :group 'watcher)

(defcustom watcher-theme 'sanityinc-tomorrow-night
  "The default color theme, change this in your /personal/preload config."
  :type 'symbol
  :group 'watcher)

(provide 'watcher-custom)
