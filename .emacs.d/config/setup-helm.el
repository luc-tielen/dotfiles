
;; Helm (see tuhdo.github.io/helm-intro.html)
(use-package helm
	     :config
	     (require 'helm-config)
	     (global-unset-key (kbd "C-x c"))
	     (global-set-key (kbd "C-p") 'helm-command-prefix)  ; TODO

	     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	     (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
	     (define-key helm-map (kbd "C-z") 'helm-select-action) ; TODO

	     (when (executable-find "curl")
	       (setq helm-google-suggest-use-curl-p t))

	     (setq helm-split-window-in-side-p t
		   helm-move-to-line-cycle-in-source t
		   helm-ff-search-library-in-sexp t
		   helm-scroll-amount 8
		   helm-ff-file-name-history-use-recentf t
		   helm-echo-input-in-header-line t)

	     (setq helm-autoresize-max-height 0)
	     (setq helm-autoresize-min-height 20)
	     (helm-autoresize-mode 1)

	     (helm-mode 1))

(provide 'setup-helm)
