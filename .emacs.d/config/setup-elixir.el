
;; TODO magit + evil-magit -> see chris mccords setup
;; TODO mode line formatting -> see chris mccords setup
;; TODO evil-surround for better wrapping of parens, "", etc

;; Activate Elixir mode
(use-package elixir-mode)

;; Alchemist mode for better Elixir integration
(use-package alchemist
  :config
  (setq alchemist-goto-elixir-source-dir "~/.elixir/elixir"
        alchemist-goto-erlang-source-dir "~/.erlang_otp/erlang"))

(provide 'setup-elixir)
