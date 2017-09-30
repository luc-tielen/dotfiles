
;; Enable evil mode (vim bindings)
(use-package evil
  :config
  (evil-mode 1)
  (setq evil-auto-indent 2             ;; Always indent 2 spaces
        evil-default-state 'normal     ;; Always start in normal mode
        evil-mode-line-format 'before  ;; Put Evil mode at beginning of modeline
        evil-cross-lines t             ;; Going down on a wrapped line goes to next part of same line
        evil-esc-delay 0)              ;; Don't wait for any other keys after escape is pressed
  ;; Make _ part of word when using b, e in evil mode
  (modify-syntax-entry (string-to-char "_") "w" (standard-syntax-table))
  (modify-syntax-entry (string-to-char "_") "w" text-mode-syntax-table)
  (modify-syntax-entry (string-to-char "_") "w" lisp-mode-syntax-table)
  (modify-syntax-entry (string-to-char "_") "w" emacs-lisp-mode-syntax-table)
  ;; Make ; do same as : outside of insert mode
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-visual-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map (kbd "gy") (kbd "gg v G y")))  ;; Yank whole buffer

;; Searching through visual blocks (using * (forward search) and # (backward-search))
(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode 1))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.075)  ;; Time between keys for key combinations
  (key-chord-mode 1))

;; Key bindings based on leader key
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  (evil-leader/set-key "=" (kbd "gg v G ="))  ;; format whole buffer
  (evil-leader/set-key-for-mode 'haskell-mode "i" 'haskell-process-load-file)
  (evil-leader/set-key-for-mode 'haskell-mode "b" 'haskell-compile)
  (evil-leader/set-key-for-mode 'haskell-mode "t" 'haskell-mode-jump-to-def-or-tag)
  (evil-leader/set-key-for-mode 'haskell-mode "h" 'haskell-hoogle)
  (evil-leader/set-key-for-mode 'rust-mode "b" 'cargo-process-build)
  (evil-leader/set-key-for-mode 'rust-mode "t" 'cargo-process-test)
  (evil-leader/set-key-for-mode 'rust-mode "r" 'cargo-process-run)
  (evil-leader/set-key-for-mode 'elm-mode "b" 'elm-compile-main)
  (evil-leader/set-key-for-mode 'elm-mode "t" 'elm-test-project)
  (evil-leader/set-key-for-mode 'elm-mode "d" 'elm-documentation-lookup)
  (evil-leader/set-key-for-mode 'elm-mode "r" 'run-elm-interactive)
  (evil-leader/set-key-for-mode 'elm-mode "g" 'elm-mode-goto-tag-at-point)
  (evil-leader/set-key-for-mode 'elixir-mode "ht" 'alchemist-help-search-at-point)
  (evil-leader/set-key-for-mode 'elixir-mode "g" 'alchemist-goto-definition-at-point))

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
