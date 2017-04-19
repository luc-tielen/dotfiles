
(use-package haskell-mode
  :config
  (require 'haskell-interactive-mode)
  (require 'haskell-process)
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (custom-set-variables
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-process-type 'stack-ghci)))

(use-package flycheck-haskell
  :config
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(use-package helm-hoogle)

(provide 'setup-haskell)
