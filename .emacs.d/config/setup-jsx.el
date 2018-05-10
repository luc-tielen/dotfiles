
(defun setup-flycheck-eslint ()
  (flycheck-select-checker 'javascript-eslint)
  (flycheck-mode))

(use-package rjsx-mode
  :config
  (add-hook 'rjsx-mode-hook #'setup-flycheck-eslint))

; TODO flycheck
; TODO eslint
; TODO company

(provide 'setup-jsx)
