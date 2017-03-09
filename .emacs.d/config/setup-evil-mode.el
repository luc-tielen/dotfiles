
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

;; Other key bindings

;; Make escape exit pretty much anything
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In delete selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'minibuffer-keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Fuzzy file finder in projects:
(use-package fiplr
  :init
  (define-key evil-normal-state-map "\C-p" 'fiplr-find-file))

(provide 'setup-evil-mode)
