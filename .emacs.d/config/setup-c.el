
;; Company mode for C / C++
(use-package cc-mode
  :config
  (define-key c-mode-map [(control space)] 'company-complete)
  (define-key c++-mode-map [(control space)] 'company-complete))

;; Company C headers
(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/3.6.1/"))

;; Proper indentation of C code
(setq c-default-style "linux"
      c-basic-offset 4)

;; In C++ mode, treat .h as a C++ file
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Add hook for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Setup GDB
(setq gdb-many-windows t ;; use gdb-many-windows by default
      gdb-show-main t)   ;; Non-nil means display source file containing the main routine at startup

(provide 'setup-c)
