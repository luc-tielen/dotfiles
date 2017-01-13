
;; Enable evil mode (vim bindings)
(use-package evil
	     :config
	     (evil-mode 1))

;; Key bindings based on leader key
(use-package evil-leader
	     :config
	     (global-evil-leader-mode)
	     (evil-leader/set-leader ",")
	     (evil-leader/set-key-for-mode 'haskell-mode "t" 'haskell-mode-tag-find))
	     
(provide 'setup-evil-mode)
