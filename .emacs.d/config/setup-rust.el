
;; Rust emacs major mode (highlighting, indenting, ...)
(use-package rust-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (setq rust-format-on-save t))

;; Cargo minor mode (cargo shortcuts)
(use-package cargo
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))


;; Code completion etc.
(use-package racer
  :init
  (add-hook 'rust-mode-hook #'company-mode)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'rust-mode-hook '(lambda ()
                               (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
                               (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))
                               (local-set-key (kbd "TAB") #'company-indent-or-complete-common))))

;; Rust syntax checking
(use-package flycheck-rust
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(provide 'setup-rust)

