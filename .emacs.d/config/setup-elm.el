
;; NOTE: see https://github.com/jcollard/elm-mode for more docs on supported features
(use-package elm-mode
  :init
  (add-to-list 'company-backends 'company-elm)
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  (setq elm-format-on-save t
        elm-tags-on-save t))

(use-package flycheck-elm
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(provide 'setup-elm)
