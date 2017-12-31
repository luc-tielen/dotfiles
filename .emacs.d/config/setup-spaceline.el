
;; Powerline
(use-package powerline
  :config
  (setq powerline-height 25))

;; Spaceline
(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-helm-mode))

(provide 'setup-spaceline)
