
;; General editor related settings
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; GUI related settings
(load-theme 'sanityinc-tomorrow-night t)
(setq inhibit-startup-message t)  ;; disables startup screen

;; GC related settings
(setq gc-cons-threshold 100000000)

;; Confirm dialog alias
(defalias 'yes-or-no-p 'y-or-n-p)

;; Disable toolbars / scrollbar:
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Disable autosave and backup
(setq auto-save-default nil)
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)  ;; spaces instead of tabs
(setq-default tab-width 4)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; Line numbers
(global-linum-mode 1)

;; Basic editing settings
(setq global-mark-ring-max 5000
      mark-ring-max 5000
      kill-ring-max 5000
      kill-whole-line t
      mode-require-final-newline t  ;; Add newline to end of file
      tab-width 4)                  ;; Default to 4 visible spaces to display tab

;; Whitespace settings
(setq-default indent-tabs-mode nil)  ;; spaces, not tabs!
(delete-selection-mode)
(global-set-key (kbd "RET") 'newline-and-indent)  ;; Auto indent after pressing enter.

;; Show whitespace in diff mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

;; Trim whitespace after edited lines
(use-package ws-butler
  :init
  (add-hook 'prog-mode-hook 'ws-butler-mode)
  (add-hook 'text-mode 'ws-butler-mode)
  (add-hook 'fundamental-mode 'ws-butler-mode))

;; Better highlighting of certain actions
(use-package volatile-highlights
  :init
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before 'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil))

;; Code snippets
(use-package yasnippet
  :defer t
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode))

;; Edit text in multiple places
(use-package iedit
  :bind (("C-;" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))

;; Company mode
(use-package company
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))  ;; semantic has precedence over clang -> delete it

;; Better scrolling
(use-package smooth-scrolling
	     :config
	     (smooth-scrolling-mode 1)
	     (setq smooth-scroll-margin 5)
	     (setq scroll-step 1 scroll-conservatively 10000)
         (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
         (setq mouse-wheel-progressive-speed nil)
         (setq mouse-wheel-follow-mouse 't))

;; Whitespace mode (shows all whitespace chars)
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; Package: projectile
(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))

;; Move around windows with shift + arrow keys
(windmove-default-keybindings)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

(provide 'setup-general)
