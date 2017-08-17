
(use-package julia-mode
  :init
  (add-to-list 'load-path "/usr/bin/julia"))

(use-package flycheck-julia
  :init
  (flycheck-julia-setup))

;; TODO bindings

(provide 'setup-julia)

