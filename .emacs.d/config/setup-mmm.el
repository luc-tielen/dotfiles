
;; Enable syntax highlighting in other modes
(use-package mmm-mode
  :config
  (setq mmm-submode-decoration-level 0)
  (setq mmm-global-mode 'maybe)
  (mmm-add-classes '((markdown-elixirp1
                      :submode elixir-mode
                      :face mmm-declaration-submode-face
                      :front "^\{:language=\"elixir\"\}[\n\r]+~~~"
                      :back "^~~~$")))
  (mmm-add-classes '((markdown-elixirp2
                      :submode elixir-mode
                      :face mmm-declaration-submode-face
                      :front "^\`\`\`elixir"
                      :back "^\`\`\`")))
  (mmm-add-classes '((markdown-elixirp3
                      :submode elixir-mode
                      :face mmm-declaration-submode-face
                      :front "^~~~\s?elixir[\n\r]"
                      :back "^~~~$")))
  (add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-elixirp1))
  (add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-elixirp2))
  (add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-elixirp3)))

(provide 'setup-mmm)
