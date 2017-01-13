
;; General editor related settings
(prefer-coding-system 'utf-8)

;; GUI related settings
(load-theme 'sanityinc-tomorrow-night t)
(setq inhibit-startup-message t)  ;; disables startup screen

;; Disable toolbars / scrollbar:
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Line numbers
(global-linum-mode 1)

;; Disable autosave and backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Better scrolling
(use-package smooth-scrolling
	     :config
	     (smooth-scrolling-mode 1)
	     (setq smooth-scroll-margin 5)
	     (setq scroll-step 1
		   scroll-conservatively 10000))

(provide 'setup-general)
