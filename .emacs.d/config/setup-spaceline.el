
;; Powerline / Spaceline
(use-package powerline
	     :config
	     (require 'spaceline-config)
	     (spaceline-emacs-theme)
	     (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
	     (setq powerline-height 25)
	     (spaceline-helm-mode))

(provide 'setup-spaceline)
