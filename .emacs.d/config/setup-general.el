
;; General editor related settings
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; GUI related settings
;;(load-theme 'noctilux t)
(load-theme 'sanityinc-tomorrow-eighties t)
;;(load-theme 'sanityinc-tomorrow-night t)
;;(load-theme 'atom-dark t)
(setq inhibit-startup-message t)  ;; disables startup screen
;; Uncomment following 2 lines if emacs font looks weird
;;(set-face-attribute 'default t :font "Inconsolata 13")
;;(set-frame-font "Inconsolata 13" nil t)
(set-frame-font "Fira Code 13")

(setq inhibit-startup-message t)  ;; disables startup screen
;; Uncomment following 2 lines if emacs font looks weird
;;(set-face-attribute 'default t :font "Inconsolata 13")
;;(set-frame-font "Inconsolata 13" nil t)

;; GC related settings
(setq gc-cons-threshold 100000000)

;; Confirm dialog alias
(defalias 'yes-or-no-p 'y-or-n-p)

;; Disable toolbars / scrollbar:
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Disable autosave and backup files
(setq auto-save-default nil
      backup-inhibited t
      make-backup-files nil
      create-lockfiles nil)

(setq-default indent-tabs-mode nil)  ;; spaces instead of tabs
(setq-default tab-width 4)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; Line numbers
(global-linum-mode 1)
;; use customized linum-format: add a addition space after the line number
(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
     (propertize (format (format "%%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)
;; Delay updates to give emacs a chance for other changes
(setq linum-delay t
      redisplay-dont-pause t)

;; Basic editing settings
(setq global-mark-ring-max 5000
      mark-ring-max 5000
      kill-ring-max 5000
      kill-whole-line t
      require-final-newline t       ;; Add newline to end of file
      tab-width 4                   ;; Default to 4 visible spaces to display tab
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

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

;; Remember cursor position of files when reopening them
(use-package saveplace
  :config
  (setq save-place-file "~/.emacs.d/saveplace")
  (setq-default save-place t))

;; Remove trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Rainbow parentheses
(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Auto complete parentheses, brackets, ...
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;; Better highlighting of certain actions
(use-package volatile-highlights
  :init
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before 'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil))

;; Highlight TODO
(use-package fic-mode
  :defer t
  :init
  (add-hook 'prog-mode-hook 'fic-mode))

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

;; Just reload tags file when it's updated without asking.
(setq tags-revert-without-query 1)

;; Company mode
(use-package company
  :init
  (global-company-mode 1)
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 15          ;; Bigger tooltip window
        company-echo-delay 0              ;; Remove annoying blinking
        company-selection-wrap-around t)  ;; Continue from top when reaching bottom
  ;; (setq company-idle-delay 1000)
  ;; (setq company-minimum-prefix-length 1)
  (delete 'company-semantic company-backends))  ;; semantic has precedence over clang -> delete it

;; Disable spellcheck
(flyspell-mode 0)

;; Flycheck (on the fly syntax checking)
(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Better scrolling
(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1)
  (setq scroll-margin 5
        smooth-scroll-margin 5
        scroll-conservatively 10000
        scroll-up-aggressively 0.01
        scroll-down-aggressively 0.01)
  (setq-default scroll-up-aggressively 0.01
                scroll-down-aggressively 0.01)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse 't))

;; Whitespace mode (shows all whitespace chars)
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; Package: projectile
(use-package projectile
  :init
  (projectile-mode t)
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-directories
        (append '("node_modules" ".svn" ".stack-work") projectile-globally-ignored-directories))
  (setq projectile-sort-order 'recently-active))

;; Move around windows with shift + arrow keys
(windmove-default-keybindings)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

(use-package eldoc)

(provide 'setup-general)
