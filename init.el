;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq user-full-name "watcher"
      user-mail-address "watcherone123@gmail.com")

(setq emacs-load-start-time (current-time))

(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Watcher is powering up... Be patient, Master %s!" current-user)

(when (version< emacs-version "25.2")
  (error "Watcher requires at least GNU Emacs 25.2, but you're running %s" emacs-version))

(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
;; Always load newest byte code
(setq load-prefer-newer t)

(defvar watcher-dir user-emacs-directory
  "The root dir of the Emacs Watcher distribution.")
(defvar watcher-core-dir (expand-file-name "core" watcher-dir)
  "The home of Watcher's core functionality.")
(defvar watcher-modules-dir (expand-file-name  "modules" watcher-dir)
  "This directory houses all of the built-in Watcher modules.")
(defvar watcher-cache-directory (expand-file-name ".cache" user-emacs-directory))
(make-directory watcher-cache-directory t)

(defvar watcher-modules-file (expand-file-name "watcher-modules-autoloads.el" watcher-dir)
  "This files contains a list of modules that will be loaded by Watcher.")


(setq recentf-save-file (expand-file-name "recentf" watcher-cache-directory))
(defun watcher-add-subfolders-to-load-path (parent-dir)
  "Add all level PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
		 (not (string-prefix-p "." f)))
	(add-to-list 'load-path name)
	(watcher-add-subfolders-to-load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path watcher-core-dir)
(add-to-list 'load-path watcher-modules-dir)
;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)



(message "Loading Watcher's core...")
;;core files
(require 'watcher-packages)
(require 'watcher-custom)
(require 'watcher-better-defaults)
(require 'watcher-ui)
(require 'watcher-misc)
;; (require 'watcher-func)
(require 'watcher-func-autoloads)
(require 'spacemacs-keys)
(require 'watcher-keybindings)

(message "Loading Watcher's modules...")
;; the modules
(if (file-exists-p watcher-modules-file)
    (load watcher-modules-file)
  (message "Missing modules file %s" watcher-modules-file)
  (message "You can get started by copying the bundled example file"))

;;load abbrev file
(load "~/.emacs.d/site-lisp/watcher-abbrev.el")
;;定制文件加载
(use-package cus-edit
  :defer t
  :init
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (load custom-file :no-error :no-message))

(message "Wacther is ready to do thy bidding, Master %s!" current-user)
(when (require 'time-date nil t)
  (message "Emacs startup time: %f seconds."
	   (time-to-seconds (time-since emacs-load-start-time))))
(put 'upcase-region 'disabled nil)
